package = 'strict'
version = 'scm-1'
source  = {
    url    = 'git://github.com/Mons/lua-strict.git',
    branch = 'master',
}
description = {
    summary  = "Write lua programs with lexically scoped strict",
    homepage = 'https://github.com/Mons/lua-strict.git',
    license  = 'BSD',
}
dependencies = {
    'lua >= 5.1'
}
build = {
    type = 'builtin',
    modules = {
        ['strict'] = 'strict.lua'
    }
}

-- vim: syntax=lua
