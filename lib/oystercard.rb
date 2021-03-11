class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1
	MINIMUM_CHARGE = 1

	attr_reader :balance, :entry_station, :history

	def initialize
		@balance = 0
		@entry_station = nil
		@history = []
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
		@entry_station = station
	end

	def in_journey?
		@entry_station != nil ? true : false
	end

	def touch_out(station)
		deduct(MINIMUM_CHARGE)
		@history << { :start => @entry_station, :finish => station }
		@entry_station = nil
	end

	private

	def max_balance_reached
		fail 'Maximum balance exceeded' if @amount + @balance > MAXIMUM_BALANCE
	end

	def min_balance_required
		fail 'Minimum balance needed' if @balance < MINIMUM_BALANCE
	end
end
