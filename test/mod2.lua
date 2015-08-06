print("# _G not under strict = ",_G)

local r,e = pcall(function()
	return GLOBAL2
end)

if r then
	print("ok 6 - mod 2 error not called",r)
else
	print("not ok 6 - mod 2 error called: ",e)
end


if GLOBAL1 == 'ok' then
	print("ok 7 - mod 2 GLOBAL1 accessible")
else
	print("not ok 7 - mod 2 GLOBAL1 accessible")
end
