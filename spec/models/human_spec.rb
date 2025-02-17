require 'rails_helper'

RSpec.describe Human, type: :model do
  it 'should have a name' do
    human = Human.new(name: '')
    expect(human).not_to be_valid
  end

  it 'should have a dna' do
    human = Human.new(name: 'Test')
    expect(human).not_to be_valid
  end

  it 'save a valid human' do
    human = Human.new(name: 'Test', dna: "AAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA")
    expect(human.save).to be true
    expect(human.human_type).to eq("liner")
  end

  describe "dna_matrix_to_string" do
    it "should convert a matrix to a string" do
      matrix = {
        0 => { 0 => "A", 1 => "A", 2 => "A", 3 => "A", 4 => "A", 5 => "A" },
        1 => { 0 => "A", 1 => "A", 2 => "A", 3 => "A", 4 => "A", 5 => "A" },
        2 => { 0 => "A", 1 => "A", 2 => "A", 3 => "A", 4 => "A", 5 => "A" },
        3 => { 0 => "A", 1 => "A", 2 => "A", 3 => "A", 4 => "A", 5 => "A" },
        4 => { 0 => "A", 1 => "A", 2 => "A", 3 => "A", 4 => "A", 5 => "A" },
        5 => { 0 => "A", 1 => "A", 2 => "A", 3 => "A", 4 => "A", 5 => "A" }
      }
      expect(Human.dna_matrix_to_string(matrix)).to eq("AAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\n")
    end
  end
end
