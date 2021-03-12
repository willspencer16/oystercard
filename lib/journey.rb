
class Journey
	attr_reader :entry_station, :history

	def initialize(oystercard)
		@entry_station = nil
		@history = []
		@oystercard = oystercard
	end

	def start(station)
		@entry_station = station
	end

	def finish(station)
		@history << { :start => @entry_station, :finish => station }
		@entry_station = nil
	end
	
end
