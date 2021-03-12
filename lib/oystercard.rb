class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1
	MINIMUM_CHARGE = 1

	attr_reader :balance

	def initialize(journey = Journey.new)
		@balance = 0
		@journey = journey
	end

	def top_up(amount)
		@amount = amount
    	@balance += amount unless max_balance_reached
	end

	def deduct(deduct_amount)
		@balance -= deduct_amount
	end

	def touch_in(station)
		min_balance_required
		@journey.start(station)
	end

	def touch_out(station)
		deduct(MINIMUM_CHARGE)
		@journey.finish(station)
	end

	private

	def max_balance_reached
		fail 'Maximum balance exceeded' if @amount + @balance > MAXIMUM_BALANCE
	end

	def min_balance_required
		fail 'Minimum balance needed' if @balance < MINIMUM_BALANCE
	end
end
