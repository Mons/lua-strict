--[[

    Usage:

    require 'strict' () -- <--- please note the (), that mean call
    require 'strict' ('fatal')
    require 'strict' ('warn')

]]

local function strict(_mode)
	local fatal = true
	if _mode and _mode == 'warn' then
		fatal = false
	end
	local declared = {}
	local function global (...)
		for _, v in ipairs{...} do declared[v] = true end
	end
	local mt = {
		__index    = function ( t,n )
			local have = rawget(t,n)
			if have ~= nil then
				return have
			end
			local have = rawget(_G,n)
			if have ~= nil then
				return have
			end
			if not declared[n] then
				local d = debug.getinfo(2)
				if d and d.what ~= 'C' then
					local msg = "variable '"..n.."' is not declared"
					if fatal then
						error(msg, 2)
					else
						print(d.short_src..':'..d.currentline..": "..msg)
					end
				end
			end
			return nil
		end;
		__newindex = function ( t,n,v )
			local have = rawget(_G,n)
			if have ~= nil or type(v) == 'function' then
				rawset(_G,n,v)
				return
			end
			if not declared[n] then
				local d = debug.getinfo(2)
				if d and d.what ~= 'C' then
					local msg = "variable '"..n.."' is not declared for set"
					if fatal then
						error(msg, 2)
					else
						print(d.short_src..':'..d.currentline..": "..msg)
					end
				end
			end
			rawset(_G,n,v)
			return
		end;
	}
	local env = {
		global = global;
	}
	env._G = env
	setmetatable(env,mt)
	setfenv(2,env)
end

return strict
