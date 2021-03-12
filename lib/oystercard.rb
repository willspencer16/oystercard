class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1
	MINIMUM_CHARGE = 1

	attr_reader :balance, :start_location, :end_location

	def initialize(journey = Journey.new)
		@balance = 0
		@journey = journey
	end

	def top_up(amount)
    @balance += amount unless max_balance_reached(amount)
	end

	def deduct
		(@start_location == nil || @end_location == nil) ? @balance -= 6 : @balance -= MINIMUM_CHARGE
	end

	def touch_in(station)
		deduct if @end_location == nil
		min_balance_required
		@end_location = nil
		@journey.start(station)
		@start_location = station
	end

	def touch_out(station)
		@end_location = station
		deduct
		@journey.finish(station)
		@start_location = nil
	end

	private

	def max_balance_reached(amount)
		fail 'Maximum balance exceeded' if amount + @balance > MAXIMUM_BALANCE
	end

	def min_balance_required
		fail 'Minimum balance needed' if @balance < MINIMUM_BALANCE
	end
end
