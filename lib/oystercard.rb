class Oystercard
	MAXIMUM_BALANCE = 90
	MIN_BALANCE = 1

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
		@in_journey = true unless min_balance_exceeded
	end

	def in_journey?
		@in_journey
	end

	def touch_out
		@in_journey = false
	end

	private

	def max_balance_reached
		fail 'Maximum balance exceeded' if @amount + @balance > MAXIMUM_BALANCE
	end

	def min_balance_exceeded
		fail 'Minimum balance needed' if @balance < MIN_BALANCE
	end
end
