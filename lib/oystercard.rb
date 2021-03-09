class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1
	MINIMUM_CHARGE = 1

	attr_reader :balance

	def initialize
		@balance = 0
		@in_journey = false
	end

	def top_up(amount)
		@amount = amount
    	@balance += amount unless max_balance_reached
	end

	def deduct(deduct_amount)
		@balance -= deduct_amount
	end

	def touch_in
		@in_journey = true unless min_balance_required
	end

	def in_journey?
		@in_journey
	end

	def touch_out
		deduct(MINIMUM_CHARGE)
		@in_journey = false
	end

	private

	def max_balance_reached
		fail 'Maximum balance exceeded' if @amount + @balance > MAXIMUM_BALANCE
	end

	def min_balance_required
		fail 'Minimum balance needed' if @balance < MINIMUM_BALANCE
	end
end
