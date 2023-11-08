-- This script demonstrates the use of thread:stop() to halt the thread execution.

-- Define the stopping condition
local stoppingCondition = 100

-- Counter to keep track of responses
local responseCounter = 0

-- Function to handle the response
function response()
    responseCounter = responseCounter + 1

    -- Check if the counter has reached the stopping condition
    if responseCounter >= stoppingCondition then
        wrk.thread:stop()
    end
end
