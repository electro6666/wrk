-- Improved reporting script with custom done() function for printing latency percentiles as CSV

-- Function to print latency percentiles as CSV
done = function(summary, latency, requests)
    local percentiles = {50, 90, 99, 99.999}

    io.write("Percentile,Latency (ms)\n")
    io.write("------------------------------\n")

    for _, p in pairs(percentiles) do
        local latencyValue = latency:percentile(p)
        io.write(string.format("%g%%,%d\n", p, latencyValue))
    end
end
