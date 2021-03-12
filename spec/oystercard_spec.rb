require './lib/oystercard.rb'

describe Oystercard do
	it 'has a balance of 0' do
		expect(subject.balance).to eq(0)
	end

	it 'can be top up the balance' do
		expect(subject).to respond_to(:top_up).with(1).argument
	end

	it 'balance is changed after top up' do
		expect { subject.top_up(10) }.to change { subject.balance }.by(10)
	end

	it 'raises an error if the maximum balance is exceeded' do
		subject.top_up(Oystercard::MAXIMUM_BALANCE)
		expect{ subject.top_up(1) }.to raise_error 'Maximum balance exceeded'
	end

	it 'responds to deduct method with an argument' do
		expect(subject).to respond_to(:deduct).with(1).argument
	end

	it 'deducts an amount from the balance' do
    	subject.top_up(20)
    	expect{ subject.deduct(3)}.to change{ subject.balance }.by -3
    end

	it 'an error is raised if a card with insufficient balance is touched in' do
		expect{ subject.touch_in('Waterloo') }.to raise_error 'Minimum balance needed'
	end

	it 'has correct amount deducted, when journey is complete' do
		subject.top_up(20)
  		subject.touch_in('Waterloo')
		expect{ subject.touch_out('Borough') }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
	end

	it 'gets touched in and stores the station it is touched in at' do
		journey_double = double('Journey')
		card = Oystercard.new(journey_double)
		card.top_up(20)

		expect(journey_double).to receive(:start).with('Waterloo')

		card.touch_in('Waterloo')
	end

	it 'gets touched out and stores the station it is touched in at' do
		journey_double = double('Journey')
		card = Oystercard.new(journey_double)
		card.top_up(20)

		expect(journey_double).to receive(:finish).with('Borough')
		
		card.touch_out('Borough')
	end
end
