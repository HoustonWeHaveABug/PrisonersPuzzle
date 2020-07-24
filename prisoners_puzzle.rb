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
		amod.each_with_index do |coef, pos|
			amod[pos] = (coef*val)%@a
		end
	end

	def sum_amods(amod1, amod2)
		amod1.each_with_index do |coef, pos|
			amod1[pos] = (coef+amod2[pos])%@a
		end
	end

	def prisoner1
		h = int_to_amod(@magic)
		@board.each_with_index do |val, pos|
			sum_amods(h, mul_amod_int(int_to_amod(pos), val))
		end
		amod_to_int(h)
	end

	def flip(pos)
		@board[pos] = (@board[pos]+@a-1)%@a
	end

	def prisoner2
		h = int_to_amod(0)
		@board.each_with_index do |val, pos|
			sum_amods(h, mul_amod_int(int_to_amod(pos), (@a-val)%@a))
		end
		amod_to_int(h)
	end

	def solve(log)
		if @a < 2
			return false
		end
		if log == true
			puts "board size #{@n}"
			puts "board #{@board}"
			puts "jailer selected square #{@magic}"
			square1 = prisoner1
			flip(square1)
			square2 = prisoner2
			puts "prisoner1 flipped square #{square1}"
			puts "board after flip #{@board}"
			puts "prisoner2 selected square #{square2}"
			@magic == square2
		else
			flip(prisoner1)
			@magic == prisoner2
		end
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
		@board = Array.new
		@n.times do
			@board.push(rand(@a))
		end
		@magic = rand(@n)
	end
end

if ARGV.size != 2 || !ARGV[0].is_integer? || !ARGV[1].is_integer?
	STDERR.puts "Invalid arguments"
	STDERR.flush
	exit false
end
puts "freedom granted ? #{PrisonersPuzzle.new(ARGV[0].to_i, ARGV[1].to_i).solve(false)}"
STDOUT.flush
