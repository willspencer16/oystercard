require './lib/oystercard.rb'

describe Oystercard do
	let(:station){ double :station }
	it 'has a balance' do
		expect(subject).to respond_to(:balance)
	end

	it 'has a balance of 0' do
		expect(subject.balance).to eq(0)
	end

	it 'can be topped up' do
		expect(subject).to respond_to(:top_up).with(1).argument
	end

	it 'balance is changed after top up' do
		expect { subject.top_up(1) }.to change { subject.balance }.by(1)
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

	it "can touch in" do
		subject.top_up(5)
		subject.touch_in(station)
		expect(subject).to be_in_journey
	end

	it "can touch out" do
		subject.top_up(5)
  		subject.touch_in(station)
  		subject.touch_out
  		expect(subject).not_to be_in_journey
	end

	it 'an error is raised if a card with insufficient balance is touched in' do
		expect{ subject.touch_in(station) }.to raise_error 'Minimum balance needed'
	end

	it 'has correct amount deducted, when journey is complete' do
		subject.top_up(20)
  		subject.touch_in(station)
		expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
	end

	it 'knows where user has travelled form' do
		subject.top_up(20)
  		subject.touch_in(station)
		expect(subject.entry_station).to eq station
	end
end