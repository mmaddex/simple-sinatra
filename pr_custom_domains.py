#!/usr/bin/env python3
"""
Script to add CNAME records in Cloudflare and create custom domains in Render
for preview environments.

Requirements:
    pip install requests python-dotenv

Environment Variables (.env file):
    CLOUDFLARE_API_TOKEN=your_token_here
    CLOUDFLARE_ZONE_ID=your_zone_id_here
    RENDER_API_KEY=your_api_key_here
    RENDER_SERVICE_ID=srv-xxxxx (set by Render in preview environments)
    RENDER_EXTERNAL_HOSTNAME=my-service-pr-123.onrender.com (set by Render)
"""

import os
import sys
import requests
from typing import Dict, Optional
from dataclasses import dataclass


@dataclass
class Config:
    """Configuration from environment variables"""
    cloudflare_token: str
    cloudflare_zone_id: str
    render_api_key: str
    render_service_id: str
    render_external_hostname: str
    
    @classmethod
    def from_env(cls):
        """Load config from environment variables"""
        # Try to load .env file if it exists
        try:
            from dotenv import load_dotenv
            load_dotenv()
        except ImportError:
            pass
        
        cloudflare_token = os.getenv('CLOUDFLARE_API_TOKEN')
        cloudflare_zone_id = os.getenv('CLOUDFLARE_ZONE_ID')
        render_api_key = os.getenv('RENDER_API_KEY')
        render_service_id = os.getenv('RENDER_SERVICE_ID')
        render_external_hostname = os.getenv('RENDER_EXTERNAL_HOSTNAME')
        
        if not all([cloudflare_token, cloudflare_zone_id, render_api_key]):
            raise ValueError(
                "Missing required environment variables:\n"
                "  CLOUDFLARE_API_TOKEN\n"
                "  CLOUDFLARE_ZONE_ID\n"
                "  RENDER_API_KEY"
            )
        
        if not render_service_id:
            raise ValueError(
                "Missing RENDER_SERVICE_ID environment variable.\n"
                "This is automatically set by Render in preview environments."
            )
        
        if not render_external_hostname:
            raise ValueError(
                "Missing RENDER_EXTERNAL_HOSTNAME environment variable.\n"
                "This is automatically set by Render in preview environments."
            )
        
        return cls(
            cloudflare_token=cloudflare_token,
            cloudflare_zone_id=cloudflare_zone_id,
            render_api_key=render_api_key,
            render_service_id=render_service_id,
            render_external_hostname=render_external_hostname
        )


class CloudflareAPI:
    """Cloudflare API client"""
    
    BASE_URL = "https://api.cloudflare.com/client/v4"
    
    def __init__(self, api_token: str, zone_id: str):
        self.api_token = api_token
        self.zone_id = zone_id
        self.session = requests.Session()
        self.session.headers.update({
            "Authorization": f"Bearer {api_token}",
            "Content-Type": "application/json"
        })
    
    def create_cname(
        self, 
        name: str, 
        target: str, 
        proxied: bool = True,
        ttl: int = 1
    ) -> Dict:
        """
        Create a CNAME record in Cloudflare
        
        Args:
            name: The DNS name (e.g., 'preview-123.example.com')
            target: The target domain (e.g., 'my-service-pr-123.onrender.com')
            proxied: Whether to proxy through Cloudflare (orange cloud)
            ttl: TTL in seconds (1 = auto when proxied)
        
        Returns:
            Response data from Cloudflare API
        """
        url = f"{self.BASE_URL}/zones/{self.zone_id}/dns_records"
        
        payload = {
            "type": "CNAME",
            "name": name,
            "content": target,
            "proxied": proxied,
            "ttl": ttl,
            "comment": "Created by automation for Render preview"
        }
        
        response = self.session.post(url, json=payload)
        response.raise_for_status()
        
        data = response.json()
        
        if not data.get('success'):
            errors = data.get('errors', [])
            raise Exception(f"Cloudflare API error: {errors}")
        
        return data['result']
    
    def get_dns_record(self, name: str) -> Optional[Dict]:
        """Check if a DNS record already exists"""
        url = f"{self.BASE_URL}/zones/{self.zone_id}/dns_records"
        params = {"name": name}
        
        response = self.session.get(url, params=params)
        response.raise_for_status()
        
        data = response.json()
        if data.get('success') and data.get('result'):
            return data['result'][0]
        
        return None
    
    def update_cname(self, record_id: str, target: str, proxied: bool = True) -> Dict:
        """Update an existing CNAME record"""
        url = f"{self.BASE_URL}/zones/{self.zone_id}/dns_records/{record_id}"
        
        # Get existing record first to preserve other fields
        response = self.session.get(url)
        response.raise_for_status()
        existing = response.json()['result']
        
        payload = {
            "type": "CNAME",
            "name": existing['name'],
            "content": target,
            "proxied": proxied,
            "ttl": 1 if proxied else existing.get('ttl', 1)
        }
        
        response = self.session.put(url, json=payload)
        response.raise_for_status()
        
        data = response.json()
        if not data.get('success'):
            errors = data.get('errors', [])
            raise Exception(f"Cloudflare API error: {errors}")
        
        return data['result']


class RenderAPI:
    """Render API client"""
    
    BASE_URL = "https://api.render.com/v1"
    
    def __init__(self, api_key: str):
        self.api_key = api_key
        self.session = requests.Session()
        self.session.headers.update({
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json"
        })
    
    def add_custom_domain(self, service_id: str, domain: str) -> Dict:
        """
        Add a custom domain to a Render service
        
        Args:
            service_id: Render service ID (e.g., 'srv-xxxxx')
            domain: The custom domain name
        
        Returns:
            Response data from Render API
        """
        url = f"{self.BASE_URL}/services/{service_id}/custom-domains"
        
        payload = {"name": domain}
        
        response = self.session.post(url, json=payload)
        
        # Render may return 409 if domain already exists
        if response.status_code == 409:
            print(f"⚠️  Domain {domain} already exists in Render")
            return {"name": domain, "status": "already_exists"}
        
        response.raise_for_status()
        return response.json()
    
    def get_custom_domains(self, service_id: str) -> list:
        """Get all custom domains for a service"""
        url = f"{self.BASE_URL}/services/{service_id}/custom-domains"
        
        response = self.session.get(url)
        response.raise_for_status()
        
        return response.json()
    
    def get_service(self, service_id: str) -> Dict:
        """Get service details"""
        url = f"{self.BASE_URL}/services/{service_id}"
        
        response = self.session.get(url)
        response.raise_for_status()
        
        return response.json()


def setup_preview_domain(
    custom_domain: str,
    config: Config,
    proxied: bool = True
) -> None:
    """
    Setup a custom domain for a Render preview environment
    
    Args:
        custom_domain: The custom domain to create (e.g., 'preview-123.example.com')
        config: Configuration object (includes RENDER_EXTERNAL_HOSTNAME and RENDER_SERVICE_ID)
        proxied: Whether to proxy through Cloudflare
    """
    cf = CloudflareAPI(config.cloudflare_token, config.cloudflare_zone_id)
    render = RenderAPI(config.render_api_key)
    
    print(f"\n🚀 Setting up preview domain: {custom_domain}")
    print(f"   Target: {config.render_external_hostname}")
    print(f"   Service: {config.render_service_id}")
    print()
    
    # Step 1: Create or update CNAME in Cloudflare
    print("📡 Step 1: Creating CNAME in Cloudflare...")
    try:
        existing = cf.get_dns_record(custom_domain)
        
        if existing:
            print(f"   → Record exists (ID: {existing['id']})")
            print(f"   → Updating to point to: {config.render_external_hostname}")
            result = cf.update_cname(existing['id'], config.render_external_hostname, proxied)
            print(f"   ✅ Updated CNAME record")
        else:
            result = cf.create_cname(custom_domain, config.render_external_hostname, proxied)
            print(f"   ✅ Created CNAME record (ID: {result['id']})")
        
        print(f"   → Name: {result['name']}")
        print(f"   → Target: {result['content']}")
        print(f"   → Proxied: {result['proxied']}")
        
    except Exception as e:
        print(f"   ❌ Failed to create CNAME: {e}")
        sys.exit(1)
    
    # Step 2: Add custom domain to Render
    print("\n🎨 Step 2: Adding custom domain to Render...")
    try:
        result = render.add_custom_domain(config.render_service_id, custom_domain)
        
        if result.get('status') == 'already_exists':
            print(f"   ℹ️  Domain already configured")
        else:
            print(f"   ✅ Added custom domain")
            print(f"   → Name: {result.get('name')}")
            print(f"   → Verification Status: {result.get('verificationStatus', 'pending')}")
        
    except Exception as e:
        print(f"   ❌ Failed to add custom domain to Render: {e}")
        print(f"   ⚠️  CNAME was created in Cloudflare but Render setup failed")
        sys.exit(1)
    
    print(f"\n✨ Success! Preview domain configured:")
    print(f"   https://{custom_domain}")
    print()
    print("Note: It may take a few minutes for DNS to propagate and SSL to provision.")


def main():
    """Main entry point"""
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Setup custom domains for Render preview environments",
        epilog="Uses $RENDER_SERVICE_ID and $RENDER_EXTERNAL_HOSTNAME from environment"
    )
    parser.add_argument(
        "custom_domain",
        help="Custom domain to create (e.g., preview-123.example.com)"
    )
    parser.add_argument(
        "--no-proxy",
        action="store_true",
        help="Don't proxy through Cloudflare (gray cloud)"
    )
    
    args = parser.parse_args()
    
    try:
        config = Config.from_env()
    except ValueError as e:
        print(f"❌ Configuration error: {e}")
        print("\nRequired environment variables:")
        print("  CLOUDFLARE_API_TOKEN=your_token")
        print("  CLOUDFLARE_ZONE_ID=your_zone_id")
        print("  RENDER_API_KEY=your_api_key")
        print("  RENDER_SERVICE_ID=srv-xxxxx (set by Render)")
        print("  RENDER_EXTERNAL_HOSTNAME=xxx.onrender.com (set by Render)")
        sys.exit(1)
    
    setup_preview_domain(
        custom_domain=args.custom_domain,
        config=config,
        proxied=not args.no_proxy
    )


if __name__ == "__main__":
    main()
