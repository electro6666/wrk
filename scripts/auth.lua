-- Improved script for handling authentication and using a token in requests

local token = nil
local initialPath = "/authenticate"
local resourcePath = "/resource"

-- Function to set authentication token in headers
local function setAuthToken()
   if not token then
      return wrk.format("GET", initialPath)
   else
      wrk.headers["X-Token"] = token
      return wrk.format("GET", resourcePath)
   end
end

-- Function to handle the response and extract the token
response = function(status, headers, body)
   if not token and status == 200 then
      token = headers["X-Token"]
   end
end

-- Define the request function
request = function()
   return setAuthToken()
end
