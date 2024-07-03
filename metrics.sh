#!/bin/bash

# Function to get CPU limits
get_cpu_limit() {
    local cpu_max_file="/sys/fs/cgroup/cpu.max"
    if [[ -f $cpu_max_file ]]; then
        read -r quota period < "$cpu_max_file"
        echo "$quota $period"
    else
        echo "Error: $cpu_max_file not found." >&2
        exit 1
    fi
}

# Function to calculate CPU percentage
calculate_cpu_percentage() {
    local usage_for_period=$1
    local quota=$2
    if [[ $quota -eq -1 ]]; then
        echo 100.0
    else
        echo "scale=2; ($usage_for_period / ($quota * 1.0)) * 100" | bc
    fi
}

# Function to get CPU usage for a period
get_cpu_usage_for_period() {
    read -r quota period <<< "$(get_cpu_limit)"
    if [[ -z $quota || -z $period ]]; then
        echo "Error: Failed to retrieve quota or period." >&2
        exit 1
    fi
    
    echo "Quota: $quota, Period: $period"  # Debugging output

    local metrics_start
    local metrics_end
    local usage_at_start
    local usage_at_end
    local usage_for_period

    metrics_start=$(get_cpu_stat_metrics)
    usage_at_start=$(echo "$metrics_start" | grep -oP '(?<=usage_usec )[0-9]+')

    if [[ -z $usage_at_start ]]; then
        echo "Error: Failed to retrieve initial CPU usage." >&2
        exit 1
    fi

    # Wait for the period (convert microseconds to seconds)
    sleep_time=$(bc -l <<< "$period / 1e6")
    if [[ -z $sleep_time || $sleep_time == 0 ]]; then
        echo "Error: Invalid sleep time." >&2
        exit 1
    fi
    
    echo "Sleeping for: $sleep_time seconds"  # Debugging output
    sleep "$sleep_time"

    metrics_end=$(get_cpu_stat_metrics)
    usage_at_end=$(echo "$metrics_end" | grep -oP '(?<=usage_usec )[0-9]+')

    if [[ -z $usage_at_end ]]; then
        echo "Error: Failed to retrieve final CPU usage." >&2
        exit 1
    fi

    usage_for_period=$((usage_at_end - usage_at_start))
    calculate_cpu_percentage "$usage_for_period" "$quota"
}

# Function to get CPU stat metrics
get_cpu_stat_metrics() {
    local cpu_stat_file="/sys/fs/cgroup/cpu.stat"
    if [[ -f $cpu_stat_file ]]; then
        cat "$cpu_stat_file"
    else
        echo "Error: $cpu_stat_file not found." >&2
        exit 1
    fi
}

# Main function to output CPU usage for the period
main() {
    get_cpu_usage_for_period
}

# Run the main function
main
