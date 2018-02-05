defmodule CalcTest do
	use ExUnit.Case
	doctest Calc

	test "seperate" do
		assert  Calc.seperate("1 - 2") == ["1", "-", "2"]
		assert  Calc.seperate("(1 - 2)") == ["(", "1", "-", "2", ")"]
	end

	test "seperate2" do 
		assert  Calc.seperate("(1(2+1)-2)") == ["(", "1","(", "2", "+", "1", ")", "-", "2", ")"]
	end
	
	test "op?" do
		assert Calc.op?("+") == true
	end

	test "parse" do
		assert Calc.parse(["1","+","3"] ,[], []) == true
	end


end
