#!/usr/bin/env luajit
require 'ext'
local big = require 'bignumber'
local pers = require 'pers'
local factors = require 'factors'
local productofdigits = require 'productofdigits'

local function alloflen(startlen,endlen, base)
	base = base or 10
	return coroutine.wrap(function()
		endlen = endlen or startlen  
		for len=startlen,endlen do
			local x = big(0, base)
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
					if x[i] < base then break end
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
	local base = tonumber(arg[3]) or 10
	
	x = big(x, base)
	local origx = x
	print('checking '..x)
	
	--local p = pers(x)
	local p
	for i=1,math.huge do
		p = i
		x = productofdigits(x, base)
		print(' -> '..tostring(x))
		if not x.maxExp or x.maxExp <= 0 then break end
	end

	print('pers='..p)
	local win, fs = checkFactors(origx)
	print('#factors', #fs)	
	print('factors='..fs:map(tostring):concat', ')
	if win then
		print('ALL FACTORS ARE SINGLE DIGIT NUMBERS')
	end
elseif cmd == 'graph' then
	
	print'digraph G {'
	
	local depthForNumber = table()

	local function follow(x,xstr)
		local depth = depthForNumber[xstr]
		if depth then return depth end
		depthForNumber[xstr] = 0
		local nx = productofdigits(x, 10)
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
	local startsum = tonumber(arg[2]) or 0
	local endsum = tonumber(arg[3]) or math.huge
	local firstpers = tonumber(arg[4]) or -1		-- set this to skip tracking smallest pers <= this pers
	
	local smallestForPers = {}
	for i=0,firstpers do
		smallestForPers[i] = big{infinity=true}
	end

	local pow7s = {}

	for sum=startsum,endsum do
		print('a+b+c+d='..sum..':')
		local _2a = big(1)
		for a=0,sum do
			local prod_2a_3b = big(_2a)
			for b=0,sum-a do
				local prod_2a_3b_5c = big(prod_2a_3b)
				
				local cmax = sum - a - b
				if a > 0 then	-- if there's a 2's digit then don't use any 5's digits
					cmax = 0
				end
				
				for c=0,cmax do
					local d = sum-a-b-c
					
					local _7d = pow7s[d]
					if not _7d then
						_7d = big.intPow_simple(7, d)
						pow7s[d] = _7d
					end
					local x = prod_2a_3b_5c * _7d
				
					local p = pers(x)
					if not smallestForPers[p] or x < smallestForPers[p] then
						smallestForPers[p] = big(x)
						print(a,b,c,d,p,x)
					end
					
					prod_2a_3b_5c = prod_2a_3b_5c * 5
				end
				prod_2a_3b = prod_2a_3b * 3
			end
			_2a = _2a * 2
		end
	end
elseif cmd == 'search' then
	local startlen = tonumber(arg[2])
	local endlen = tonumber(arg[3])
	local depth = tonumber(arg[4])
	local base = tonumber(arg[5]) or 10

	local smallestForPers = {}

	local pmax = 0
	local count = 0
	for x in alloflen(startlen, endlen, base) do
assert(x.base == base)	
		count = count + 1
		local p = pers(x)
		pmax = math.max(pmax, p)
		
		if not depth or p == depth then
			if not smallestForPers[p] or x < smallestForPers[p] then
				smallestForPers[p] = big(x)
				--local win, fs = checkFactors(x)
				--fs = fs:map(function(f) return f:toBase(base) end)
				print(x, 'pers='..p
					--..' factors='..fs:map(tostring):concat','..(win and ' (all single digit)' or '')
				)
			end
		end
	end
	print('max persistence '..pmax)
end
