--[[
Copyright (c) 2010 Scott Vokes <vokes.s@gmail.com>
 
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:
 
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
--]]

local debug = debug

---A simple module to run a hook after the main script is read.
-- Requires the debug library.
module("endhook")


---Set the hook.
-- @param f The function to call.
-- @param level How many stack levels away from this call to hook.
-- Defaults to 4, so a file requiring a library calling this is hooked.
function hook(f, level)
   level = level or 4
   local info = debug.getinfo(level, "S")
   local file = info.source

   function hook(ev, line, c)
      local info = debug.getinfo(2, "S")
      if info.what == "main" and info.source == file then f() end
   end
   
   debug.sethook(hook, "r")
end
