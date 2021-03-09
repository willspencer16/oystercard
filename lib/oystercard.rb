class Oystercard
	MAXIMUM_BALANCE = 90

	attr_reader :balance

	def initialize
		@balance = 0
	end

	def top_up(amount)
		@amount = amount
    	@balance += amount unless max_balance_reached
	end

	def deduct(deduct_amount)
		@balance -= deduct_amount
	end

	private

	def max_balance_reached
		fail 'Maximum balance exceeded' if @amount + @balance > MAXIMUM_BALANCE
	end
end
