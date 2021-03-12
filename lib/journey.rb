
class Journey
	attr_reader :entry_station, :history

	def initialize
		@entry_station = nil
		@history = []
	end

	def start(station)
		@entry_station = station
	end

	def finish(station)
		@history << { :start => @entry_station, :finish => station }
		@entry_station = nil
	end

	def fare
	end

	def complete?
	end
end