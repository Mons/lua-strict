require 'strict' ()

print("# _G under strict = ",_G)
-- do
-- 	local d = debug.getinfo(1)
-- 	-- d.short_src..':'..tostring(caller.currentline)
-- 	print("call strict from ",d.short_src..':'..tostring(d.currentline), "_G = ",_G)
-- end

local r,e = pcall(function()
	return GLOBAL1
end)

if r then
	print("not ok 1 - mod 1 error not called",r)
else
	print("ok 1 - mod 1 error called: ",e)
end

local r,e = pcall(function()
	GLOBAL1 = 1
end)

if r then
	print("not ok 2 - mod 1 error not called",r)
else
	print("ok 2 - mod 1 error called: ",e)
end

global('GLOBAL1')

local r,e = pcall(function()
	return GLOBAL1
end)

if r then
	print("ok 3 - mod 1 error not called",r,e)
else
	print("not ok 3 - mod 1 error called: ",e)
end

local r,e = pcall(function()
	GLOBAL1 = 'ok'
end)

if r then
	print("ok 4 - mod 1 error not called",r)
else
	print("not ok 4 - mod 1 error called: ",e)
end


(function ()
	(function ()
		(function ()
			require 'strict' ()
		end)()
	end)()	
end)()

function test1() end

local r,e = pcall(function()
	function test() end
end)

if r then
	print("ok 5 - mod 1 function creatable",r)
else
	print("not ok 5 - mod 1 function not creatable",e)
end

