#!/usr/bin/env luajit
local big = require 'bignumber'

local function pers(x)
	for i=1,math.huge do
-- debugging:
--print(i, x)
		local s = big(x[0]) 
		for j=1,#x do
			s = s * big(x[j])
		end
		x = s
		if not x.maxExp or x.maxExp <= 0 then return i end
	end
end

--[[
1 = 2
2 = 25
3 = 39
4 = 77
5 = 679
6 = 6788
7 = 68889
--]]

--local x = big'277777788888899'

local count = 0
local maxsofar = 0
for len=5,5 do
	local x = big()
	x.minExp = 0
	for i=0,len-1 do
		x[i] = 1
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
		
		--print(x)
		local p = pers(x)
		maxsofar = math.max(maxsofar, p)
		print(x, pers(x), maxsofar)

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
	--[[
	while true do
		for i=1,len do
			t[i] = t[i] + 1
		end
	end

local x = big(1)
while true do
	x = x + 1

	--]]
end
