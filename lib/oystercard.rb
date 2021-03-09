class Oystercard
	MAXIMUM_BALANCE = 90

	attr_reader :balance

	def initialize
		@balance = 0
		@in_journey = nil
	end

	def top_up(amount)
		@amount = amount
    	@balance += amount unless max_balance_reached
	end

	def deduct(deduct_amount)
		@balance -= deduct_amount
	end

	def touch_in
		@in_journey = true
	end

	def in_journey?
		@in_journey
	end

	private

	def max_balance_reached
		fail 'Maximum balance exceeded' if @amount + @balance > MAXIMUM_BALANCE
	end
end
