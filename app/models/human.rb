class Human < ApplicationRecord
  validates :name, :dna, presence: true
end
