-- Improved wrk.lua script

local wrk = {
   scheme  = "http",
   host    = "localhost",
   port    = nil,
   method  = "GET",
   path    = "/",
   headers = {},
   body    = nil,
   thread  = nil,
}

-- Function to resolve host and set up addresses
function wrk.resolve(host, service)
   local addrs = wrk.lookup(host, service)

   -- Filter and remove addresses that fail to connect
   for i = #addrs, 1, -1 do
      if not wrk.connect(addrs[i]) then
         table.remove(addrs, i)
      end
   end

   wrk.addrs = addrs
end

-- Function to set up each thread
function wrk.setup(thread)
   thread.addr = wrk.addrs[1]

   if type(setup) == "function" then
      setup(thread)
   end
end

-- Function to format the request
function wrk.formatRequest(method, path, headers, body)
   local method  = method or wrk.method
   local path    = path or wrk.path
   local headers = headers or wrk.headers
   local body    = body or wrk.body
   local s       = {}

   -- Ensure the Host header is set
   if not headers["Host"] then
      local host = wrk.host
      local port = wrk.port
      host = host:find(":") and ("[" .. host .. "]") or host
      host = port and (host .. ":" .. port) or host
      headers["Host"] = host
   end

   headers["Content-Length"] = body and string.len(body)

   s[1] = string.format("%s %s HTTP/1.1", method, path)

   for name, value in pairs(headers) do
      s[#s + 1] = string.format("%s: %s", name, value)
   end

   s[#s + 1] = ""
   s[#s + 1] = body or ""

   return table.concat(s, "\r\n")
end

-- Function to initialize the script
function wrk.init(args)
   if type(init) == "function" then
      init(args)
   end

   local req = wrk.formatRequest()
   wrk.request = function()
      return req
   end
end

return wrk
