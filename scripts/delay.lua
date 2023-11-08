-- Improved script for adding a random delay before each request

-- Define the minimum and maximum delay in milliseconds
local minDelay = 10
local maxDelay = 50

-- Function to generate a random delay within the defined range
function delay()
   return math.random(minDelay, maxDelay)
end
