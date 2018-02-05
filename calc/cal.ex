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

	

	def parse(l, n, op) do 
		[head | tail] = l
		cond do 
			not op?(head) -> 
				case Integer.parse(head) do
					{:error, reason} -> IO.puts "Error: #{reason}"
					{x, y} -> n = n ++ [x]
				end
			head == "(" ->
				do something 
			head == ")" ->
				do something
			op?(head) -> 
				do something else
			
	end

	

	def calc(x, op, y) {
		cond do 
			op == "+" -> x + y
			op == "-" -> x - y
			op == "*" -> x * y
			op == "/" -> div(x, y)
			true -> 
		end
	end
end 
