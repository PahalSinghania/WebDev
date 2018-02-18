defmodule Calc do

	# starter code adopted and modified from notes 
	# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/07-elixir/rw.exs
	def main() do
		case IO.gets("> ") do
			:eof ->
				IO.puts "All done"
			{:error, reason} ->
				IO.puts "Error: #{reason}"
			line ->
				IO.puts(eval(line))
				main()
		end
	end

	def eval(line) do
		{n, op} = seperate(line) |> parse([], []) 
		List.first(n)
	end 
	
	def seperate(line) do 
		String.trim(line, " ")
		|> String.replace(~r/\(/,  " \\0  " ) 
		|> String.replace(~r/\)/,  " \\0  " )
		|> String.replace(~r/\+/,  " \\0  " )
		|> String.replace(~r/\-/,  " \\0  " )
		|> String.replace(~r/\*/,  " \\0  " )
		|> String.replace(~r/\//,  " \\0  " )	
		|> String.split(" ")
		|> Enum.filter(fn a -> a != "" && a != " " end)
	end 

	def op?(x) do
		x == "+" or x == "-" or x == "/" or x == "*"
	end

	#https://rosettacode.org/wiki/Determine_if_a_string_is_numeric#Elixir
	defp num?(x) do
		case Integer.parse(x) do
			{_,_} -> true
			{_num, ""} -> true
      			_  -> false
		end
	end

	def compute(n, op) do 
		[fun| op] = op
		[y | n] = n 
		[x | n] = n 
		n = [calc(x, fun, y)] ++ n
		{n, op}
	end

	def parse(l, n, op) do 
		if l != [] do 
			[head | tail] = l 
		 	cond do
				num?(head)->
					{x, _} = Integer.parse(head)
					n = [x] ++ n
				head == "(" ->
					op = [head] ++ op
				head == ")" ->
					{n, op} = sum_op(n, op)
				op?(head) -> 
					{n, op} = add_op(head, n, op)
					#op = [head] ++ op
				true-> nil 
			end	
			{n, op} = parse(tail, n, op)
		end
		{n, op} = sum_op(n, op)
	end
	
	def add_op(x, n, op) do 
		if op != [] do 
			[head | _] = op		
			if (head == "*" or head =="/" or x == "+" or x == "-") and op?(head) do
					{n, op} = compute(n, op)
			end 
		end
		op = [x] ++ op
		{n, op}	
	end

	def sum_op(n, op) do 
		if op != [] do 
			[head | tail] = op
			cond do
				(head == "(") ->
					op = List.delete_at(op, 0)
				op?(head) ->
					{n, op} = compute(n, op)
					{n, op} = sum_op(n, op)
			end
		end 
		{n, op}
	end
	
	def calc(x, op, y) do
		cond do 
			op == "+" -> x + y
			op == "-" -> x - y 
			op == "*" -> x * y
			op == "/" -> div(x, y)
			true -> nil
		end
	end
end 
