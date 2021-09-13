-- Lua-tester
-- a unit tester consisting of only one function
-- https://github.com/Losiel/Lua-tester

local S = {
	tests_data = nil;
		-- Contains the hierachy of tests and if one of them was succesfull or not
		-- example:
		-- {
		--   name = "Test name";
		--   success = true;
		--   tests = {
		--     {name = "Some test";	success = true; tests = {};},
		--     {name = "Failing test"; success = false; error = "Some error!";}
		--   }
		-- }
	parent = nil; -- A pointer to the parent tests table
}

local function test(name, callback)
	assert(type(name)     == "string",   "Name must be an string")
	assert(name           ~= "",         "Name cannot be empty")
	assert(type(callback) == "function", "Callback must be a function")
	
	local firstTest = (S.tests_data == nil)
	local parent = S.parent
	if (firstTest) then -- first test running
		parent = {}
		S.tests_data = parent
	end
	
	local test_object = {
		name = name;
		tests = {};
	}
	
	-- add test to tests_data
	table.insert(parent, test_object)
	
	S.parent = test_object.tests -- for nested tests
	
	-- time to run callback
	local SUC, RET = pcall(callback)
	test_object.success = SUC
	test_object.error = RET
	S.parent = parent
	
	-- if this is the first test ran in the tree, we must set everything to how it was before
	-- and print out the results
	if (not firstTest) then return SUC end
	
	local errors = {}
	local function printResults(test, identation)
		print( string.rep("   ", identation) .. test.name .. ": " .. (test.success and "PASS" or "FAIL") )
		
		if (not test.success) then
			table.insert(errors, test)
		end
		
		for _, test in ipairs(test.tests) do
			printResults(test, identation + 1)
		end
	end
	printResults(test_object, 0)
	
	-- Print out errors
	if #errors > 0 then
		print('\n-- Errors in "' .. name .. '" --')
		for _, test in ipairs(errors) do
			print('* Error in test "' .. test.name .. '"')
			print(test.error)
		end
	end
	
	S.parent = nil
	S.tests_data = nil
end

return test
