-- example script that demonstrates the use of setup() to pass
-- a random server address to each thread

local addrs = nil

-- Function to set up each thread with a random server address
function setup(thread)
   if not addrs then
      addrs = wrk.lookup(wrk.host, wrk.port or "http")
      for i = #addrs, 1, -1 do
         if not wrk.connect(addrs[i]) then
            table.remove(addrs, i)
         end
      end
   end

   thread.addr = addrs[math.random(#addrs)]
end

-- Function to initialize the script
function init(args)
   local msg = "Thread addr: %s"
   print(msg:format(wrk.thread.addr))
end
