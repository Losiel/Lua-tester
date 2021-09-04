# Lua-tester
a very simple unit tester for Lua

## Documentation
its just one function `test`
```lua
test("my test", function()
  assert(true == true)
end)

-- my test: PASS
```
you can even nest them
```lua
local player = {}

test("describe player", function()
  test("player exists", function()
    assert(player)
  end)
end)

-- describe player: PASS
--    player exists: PASS
```

it tells you the errors of the tests that failed
```lua
test("lua math", function()
  test("add", function()
    assert(10 + 1 == 11)
  end)
  
  test("substract", function()
    assert(10 - 1 == 9)
  end)
  
  test("multiply", function()
    assert(50 * 10 == 100)
  end)
  
  test("divide", function()
    assert(360 / 10 == 36)
  end)
end)

--[[
lua math: PASS
   add: PASS
   substract: PASS
   multiply: FAIL
   divide: PASS

-- Errors in "lua math" --
* Error in test "multiply"
Math test.lua:87: assertion failed!
]]
```

## Example
```lua
test("Describe table.insert", function()
	test("Located in environment", function()
		assert(table.insert)
	end)
	
	test("It moves the elements in the zone that was inserted", function()
		local ARR = {1, 2}
		
		table.insert(ARR, 2, 3)
		
		assert(ARR[3] == 2 and ARR[2] == 3)
	end)
	
	test("By default it inserts to the end of table", function()
		local ARR = {1, 2}
		
		table.insert(ARR, "Hello")
		
		assert(ARR[3] == "Hello")
	end)
end)

-- Describe table.insert: PASS
--    Located in environment: PASS
--    It moves the elements in the zone that was inserted: PASS
--    By default it inserts to the end of table: PASS
```
