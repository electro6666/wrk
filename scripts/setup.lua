-- Improved script demonstrating the use of setup() to pass data to and from threads

local counter = 1
local threads = {}

-- Function to set up each thread and pass data
function setup(thread)
   thread:set("id", counter)
   thread:set("requests", 0)  -- Initialize the requests counter
   thread:set("responses", 0) -- Initialize the responses counter
   table.insert(threads, thread)
   counter = counter + 1
end

-- Function to initialize the script
function init(args)
   -- Variables to keep track of global requests and responses
   requests = 0
   responses = 0

   local msg = "Thread %d created"
   for _, thread in ipairs(threads) do
      local id = thread:get("id")
      print(msg:format(id))
   end
end

-- Function to handle the request
function request()
   local threadRequests = wrk.thread:get("requests")
   threadRequests = threadRequests + 1
   wrk.thread:set("requests", threadRequests)
   requests = requests + 1
   return wrk.request()
end

-- Function to handle the response
function response(status, headers, body)
   local threadResponses = wrk.thread:get("responses")
   threadResponses = threadResponses + 1
   wrk.thread:set("responses", threadResponses)
   responses = responses + 1
end

-- Function to display the summary for each thread
function done(summary, latency, requests)
   for _, thread in ipairs(threads) do
      local id = thread:get("id")
      local threadRequests = thread:get("requests")
      local threadResponses = thread:get("responses")
      local msg = "Thread %d made %d requests and got %d responses"
      print(msg:format(id, threadRequests, threadResponses))
   end
end
