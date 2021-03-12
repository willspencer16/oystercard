require './lib/journey.rb'

describe Journey do

	it 'has an entry station' do
  		expect(subject).to respond_to(:start).with(1).argument
	end

	it 'knows where user has travelled form' do
		subject.start('Waterloo')
		expect(subject.entry_station).to eq('Waterloo')
	end

	it 'has an exit station' do
  		expect(subject).to respond_to(:finish).with(1).argument
	end

	it 'resets after finishing' do
		subject.start('Waterloo')
		subject.finish('Borough')
		expect(subject.entry_station).to eq(nil)
	end

	it 'shows all my previous trips' do
		subject.start('Waterloo')
		subject.finish('Borough')
		expect(subject.history).to eq([{ :start => 'Waterloo', :finish => 'Borough' }])
	end

	it 'has somewhere to store history' do
		expect(subject.history).to eq([])
	end
end