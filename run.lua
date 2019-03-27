#!/usr/bin/env luajit
require 'ext'
local big = require 'bignumber'
local pers = require 'pers'
local factors = require 'factors'
local productofdigits = require 'productofdigits'

local function alloflen(startlen,endlen)
	return coroutine.wrap(function()
		endlen = endlen or startlen  
		for len=startlen,endlen do
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
				coroutine.yield(x)
			
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
	end)
end

local function checkFactors(x)
	local fs = factors(x)
	local fail
	for _,f in ipairs(fs) do
		if f.maxExp and f.maxExp >= 1 then 
			fail = true 
			break 
		end
	end
	return (not fail), fs
end

local cmd = arg[1]

if cmd == 'check' then
	local x = assert(arg[2])
	x = big(x)
	local origx = x
	print('checking '..x)
	
	--local p = pers(x)
	local p
	for i=1,math.huge do
		p = i
		x = productofdigits(x)
		print(' -> '..tostring(x))
		if not x.maxExp or x.maxExp <= 0 then break end
	end

	print('pers='..p)
	local win, fs = checkFactors(origx)
	print('#factors', #fs)	
	print('factors='..fs:map(tostring):concat', ')
	if win then
		print('ALL FACTORS ARE GOOD')
	end
elseif cmd == 'graph' then
	
	print'digraph G {'
	
	local depthForNumber = table()

	local function follow(x,xstr)
		local depth = depthForNumber[xstr]
		if depth then return depth end
		depthForNumber[xstr] = 0
		local nx = productofdigits(x)
		if nx == x then nx = big(0) end
		local nxstr = tostring(nx)
		local ndepth = #nxstr == 1 and 0 or depthForNumber[nxstr]
		if not ndepth then
			ndepth = follow(nx,nxstr)
		end

		depth = ndepth + 1
		if xstr == nxstr then depth = 0 end
		depthForNumber[xstr] = depth

		print('\t'..xstr..' -> '..nxstr..' [label="'..depth..'"];')
	
		return depth
	end

	local smallestForPers = {}
	local function gfollow(x,xstr)
		local depth = follow(x,xstr)
		if not smallestForPers[depth] or x < smallestForPers[depth] then
			smallestForPers[depth] = big(x)
			io.stderr:write('next smallest for depth=',depth,' is ',xstr,'\n')
			io.stderr:flush()
		end
	end

	for x in alloflen(1,11) do
		-- first trace the 1-digits back
		local xstr = tostring(x)
		gfollow(x,xstr)

		-- then trace the 1-digits forward
		while true do
			local win, fs = checkFactors(x)
			if not win then break end
			local xstr = fs:map(tostring):concat()
			if depthForNumber[xstr] then break end
			x = big(xstr)
			gfollow(x,xstr)
			-- check the new x's factors as well
		end
	end

	print'}'
elseif cmd == 'build' then	-- build up by searching 2^a * 3^b * 5^c * 7^d
	local smallestForPers = {}
	local lasttime = os.time()
	for sum=0,math.huge do
		local thistime = os.time()
		if thistime ~= lasttime then
			lasttime = thistime
			print('sum of powers of primes: '..sum)
		end
		local _2a = big(1)
		for a=0,sum do
			local _3b = big(1)
			for b=0,sum-a do
				local _5c = big(1)
				local pab = _2a * _3b
				
				local cmax = sum - a - b
				if a > 0 then	-- if there's a 2's digit then don't use any 5's digits
					cmax = 0
				end
				
				for c=0,cmax do
					local d = sum-a-b-c
					
					--local _7d = big(7)^big(d)
					local _7d = big(7):intPow_simple(big(d))

					local pcd = _5c * _7d
					local x = pab * pcd
					--local x = _2a * _3b * _5c * _7d
				
					local p = pers(x)
					if not smallestForPers[p] or x < smallestForPers[p] then
						smallestForPers[p] = big(x)
						print(a,b,c,d,p,x)
					end
				
					_5c = _5c * 5
				end
				_3b = _3b * 3
			end
			_2a = _2a * 2
		end
	end
elseif cmd == 'search' then
	local depth = tonumber(arg[2])
	
	local startlen = arg[3]
	startlen = assert(tonumber(startlen), "couldn't convert "..tostring(startlen))

	local count = 0
	for x in alloflen(startlen) do
		count = count + 1
		local p = pers(x)
		if p == depth then
			local win, fs = checkFactors(x)
			print(x, 'pers='..p..' factors='..fs:map(tostring):concat','..(win and ' WIN!' or ''))
		end
	end
end
