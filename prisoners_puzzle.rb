class String
	def is_integer?
		self.to_i.to_s == self
	end
end

class PrisonersPuzzle
	def int_to_amod(val)
		amod = Array.new
		@d.times do
			amod.push(val%@a)
			val /= @a
		end
		amod
	end

	def amod_to_int(amod)
		val = 0
		pow = 1
		amod.each do |coef|
			val += coef*pow
			pow *= @a
		end
		val
	end

	def mul_amod_int(amod, val)
		mul = Array.new
		amod.each do |coef|
			mul.push((coef*val)%@a)
		end
		mul
	end

	def sum_amods(amod1, amod2)
		sum = Array.new
		amod1.zip(amod2) do |coef1, coef2|
			sum.push((coef1+coef2)%@a)
		end
		sum
	end

	def opp_amod(amod)
		opp = Array.new
		amod.each do |coef|
			opp.push((@a-coef)%@a)
		end
		opp
	end

	def hash(val)
		h = int_to_amod(val)
		@board.each_with_index do |val, pos|
			h = sum_amods(h, mul_amod_int(int_to_amod(pos), val))
		end
		h
	end

	def prisoner1
		amod_to_int(hash(@magic))
	end

	def flip(pos)
		@board[pos] = (@board[pos]+@a-1)%@a
	end

	def prisoner2
		amod_to_int(opp_amod(hash(0)))
	end

	def solve
		if @a < 2
			return false
		end
		square1 = prisoner1
		flip(square1)
		puts "prisoner1 flipped square #{square1}"
		puts "board after flip #{@board}"
		square2 = prisoner2
		puts "prisoner2 selected square #{square2}"
		@magic == square2
	end

	def initialize(a, d)
		if a < 2 || d < 0
			@a = 1
			@d = 0
		else
			@a = a
			@d = d
		end
		@n = @a**@d
		puts "board size #{@n}"
		@board = Array.new
		@n.times do
			@board.push(rand(@a))
		end
		puts "board #{@board}"
		@magic = rand(@n)
		puts "jailer selected square #{@magic}"
	end
end

if ARGV.size != 2 || !ARGV[0].is_integer? || !ARGV[1].is_integer?
	STDERR.puts "Invalid arguments"
	STDERR.flush
	exit false
end
puts "freedom granted ? #{PrisonersPuzzle.new(ARGV[0].to_i, ARGV[1].to_i).solve}"
STDOUT.flush
