ssl_bind '0.0.0.0', ENV.fetch('PORT', 3000) do |ctx|
  ctx.ssl_version = :TLSv1
  ctx.min_version = :TLS1
end
