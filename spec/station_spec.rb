require './lib/station.rb'

describe Station do
	subject {described_class.new(name: "Old Street", zone: 1)}

	it 'has a name on creation' do
		expect(subject.name).to eq("Old Street")
	end

	it 'has a zone on creation' do
		expect(subject.zone).to eq(1)
	end
end