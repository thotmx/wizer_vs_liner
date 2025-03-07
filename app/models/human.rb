class Human < ApplicationRecord
  validates :name, :dna, presence: true
  before_save :check_for_liner

  attr_accessor :dna_matrix

  def self.from_human_params(params)
    clean_params = params.to_hash.with_indifferent_access
    { name: clean_params[:name], dna: dna_matrix_to_string(clean_params[:dna_matrix]) }
  end

  def self.dna_matrix_to_string(dna_matrix)
      dna_matrix.inject("") do |result, (i, value)|
      row = value
      row_string = row.map { |key, value| value }.join
      result.concat(row_string, "\n")
    end
  end

  def check_for_liner
    if Dna::MutantDetector.call(dna.split("\n"))
      self.human_type = "liner"
    else
      self.human_type = "wizer"
    end
  end

  def initialize_matrix
    if self.dna.nil?
      self.dna_matrix = Array.new(Rails.configuration.dna["rows"]) { Array.new(Rails.configuration.dna["cols"]) { "A" } }
    else
      self.dna_matrix = dna.split("\n").map { |row| row.split("") }
    end
  end
end
