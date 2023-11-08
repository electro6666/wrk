-- Improved HTTP POST script

-- Define the HTTP method
local httpMethod = "POST"

-- Define the request body
local requestBody = "foo=bar&baz=quux"

-- Define the Content-Type header
local contentTypeHeader = "application/x-www-form-urlencoded"

-- Configure the script
wrk.method = httpMethod
wrk.body = requestBody
wrk.headers["Content-Type"] = contentTypeHeader
