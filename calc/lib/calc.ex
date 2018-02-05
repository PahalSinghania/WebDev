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
	        seperate(line)	
		|> parse([], [])
	end 
	
	def seperate(line) do 
		String.trim(line, " ")
		|> String.split("")
		|> Enum.filter(fn a -> a != "" && a != " " end)
	end 

	def op?(x) do
		x == "+" or x== "-" or x == "/" or x == "*"
	end

#	def compute(n, op) do 
#		[n1 | n-tail] = n
#		[n2 | n2-tail] = n-tail
#		[fun| op-tail] = op
#		n = n2-tail ++ calc(n1, fun, n2)
#		{n, op-tail}
#	end

	def parse(l, n, op) do 
		[head | tail] = l
		cond do 
			not op?(head) -> 
				try do
					{x,y} = Integer.parse(head)
					n = n ++ [x]
				catch 
					value -> nil
				end
			head == "(" ->
				op = op  ++ [head]
		#	head == ")" ->
		#		{n, op} = compute(n, ops)
		#	op?(head) -> 
				#do something else
		end			
	end

	

	def calc(x, op, y) do
		cond do 
			op == "+" -> x + y
			op == "-" -> x - y
			op == "*" -> x * y
			op == "/" -> div(x, y)
			true -> 
		end
	end
end 
