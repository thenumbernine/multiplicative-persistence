#!/usr/bin/env luajit
local big = require 'bignumber'
local pers = require 'pers'

local count = 0
local maxsofar = 0
for len=2,2 do
	local x = big()
	x.minExp = 0
	for i=0,len-1 do
		x[i] = 2
	end
	local done
	while not done do
		
		for i=len-1,0,-1 do
			if x[i] ~= 0 then
				x.maxExp = i
				break
			end
		end
		count = count + 1
		
		local p = pers(x)
		maxsofar = math.max(maxsofar, p)
if maxsofar == 2 then 
	print(x, pers(x), maxsofar)
	local fs = factors(x)
	print'factors:'
	for _,f in ipairs(fs) do
		print('', f)
	end
	os.exit() 
end

		local inc = false
		for i=0,len-1 do
			if inc then
				for j=i-1,0,-1 do
					x[j] = x[i]+1
				end
			end
			inc = false
			x[i] = x[i] + 1
			if x[i] < 10 then break end
			x[i] = x[i+1]
			if i == len-1 then 
				done = true 
				if inc then
					for j=i,0,-1 do
						x[j] = x[i+1]+1
					end
				end
				break 
			end
			inc = true
		end
		if done then break end
	end
end
