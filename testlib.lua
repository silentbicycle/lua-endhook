local require, print = require, print

module(..., package.seeall)

require "endhook"
endhook.hook(function () print("*Running end hook*") end)
