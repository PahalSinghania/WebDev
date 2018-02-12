defmodule CalcTest do
	use ExUnit.Case
	doctest Calc

	test "seperate" do
		assert  Calc.seperate("1 - 2") == ["1", "-", "2"]
		assert  Calc.seperate("(1 - 2)") == ["(", "1", "-", "2", ")"] 
		assert  Calc.seperate("(1(2+1)-2)") == ["(", "1","(", "2", "+", "1", ")", "-", "2", ")"]
		assert  Calc.seperate("( 21 ( 2 + 1 ) - 2 )") == ["(", "21","(", "2", "+", "1", ")", "-", "2", ")"]

	end
	
	test "op?" do
		assert Calc.op?("+") == true
	end

	test "parse" do
		assert Calc.parse(["5","-","4"] ,[], []) == {[1], []}
		assert Calc.parse(["1"] ,[4], ["+"]) == {[5], []}
		assert Calc.parse(["-"] ,[4,1], []) == {[-3], []}
		assert Calc.parse(["-", "1"] ,[4], []) == {[3], []}
	end
	
	test "add_op" do
                assert Calc.add_op("+", [3, 2, 1], ["+"]) == {[5, 1 ], ["+"]}
		assert Calc.add_op("+", [3, 3], []) == {[3, 3], ["+"]}
		assert Calc.add_op("*", [3, 2, 1], ["+"]) == {[3, 2, 1], ["*", "+"]}
		assert Calc.add_op("+", [3, 2, 1], ["*"]) == {[6, 1], ["+"]}
		assert Calc.add_op("+", [3, 2, 1], ["-"]) == {[-1, 1], ["+"]}
		assert Calc.add_op("+", [3, 5, 10], ["/"]) == {[1, 10], ["+"]}
	 end
	
	
	test "compute" do
		assert Calc.compute([1 ,3], ["+"]) == {[4],[]}
		assert Calc.compute([1 ,3], ["-"]) == {[2],[]}
		assert Calc.compute([1, 2, 3], ["+"]) == {[3, 3], []}

	end

	test "eval" do
		assert Calc.eval("4 - 3") == 1
		assert Calc.eval("1 + 2 + 3") == 6
		assert Calc.eval("1 + 2 + 3 + 4 + 5") == 15
		assert Calc.eval("1 + 2 * 3 + 5") == 12
		assert Calc.eval("1 + 2 * 3 + 5 / 2 - 1") == 8
		assert Calc.eval("4 - 2 + 3") == 5
		assert Calc.eval("4 - (2 + 3)") == -1
		assert Calc.eval("24 / 6 + (5 - 4)") == 5
		assert Calc.eval("8 / 2 + (5 - 4) + 3 + (9 * 3) / ( (4 * 2) + 1)") == 11
		assert Calc.eval("((4 * 2) + 1)") == 9
		assert Calc.eval("(9 * 3) / ( (4 * 2) + 1)") == 3
	end
	
	test "calc" do
		assert Calc.calc(1, "+", 3) == 4
	end
end
