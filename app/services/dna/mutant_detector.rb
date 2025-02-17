class Dna::MutantDetector
  MUTANT_SEQUENCE = Rails.configuration.dna["mutant_sequence"]
  NUMBER_OF_MUTATIONS = Rails.configuration.dna["number_of_mutations"]

  def call(dna)
    return false if dna.empty?

    return true if number_of_matches(dna) >= NUMBER_OF_MUTATIONS

    false
  end

  def self.call(dna)
    new.call(dna)
  end

  private

  def number_of_matches(dna)
    matches_in_horizontal(dna) +  matches_in_vertical(dna) + matches_in_diagonals(dna)
  end

  def matches_in_row(row)
    row.scan(/(A{#{MUTANT_SEQUENCE}}|T{#{MUTANT_SEQUENCE}}|C{#{MUTANT_SEQUENCE}}|G{#{MUTANT_SEQUENCE}})/).count
  end

  def sum_matches_in_row(matrix)
    matrix.inject(0) do |sum, row|
      sum + matches_in_row(row)
    end
  end

  def matches_in_vertical(dna)
    # Transpose the matrix to get the columns
    transposed_matrix = dna.map { |row| row.chars }.transpose
    columns = transposed_matrix.map { |row| row.join }
    sum_matches_in_row(columns)
  end

  def generate_diagonals(dna)
    # Generate the diagonals from the matrix
    diagonals = []
    dna.each_with_index do |row, i|
      row.chars.each_with_index do |cell, j|
        diagonals << (0...MUTANT_SEQUENCE).map { |x| dna[i + x][j + x] if i + x < dna.size && j + x < dna.size }.join
        diagonals << (0...MUTANT_SEQUENCE).map { |x| dna[i - x][j + x] if i - x >= 0 && j + x < dna.size }.join
      end
    end
    diagonals
  end

  def matches_in_diagonals(dna)
    diagonals = generate_diagonals(dna)
    sum_matches_in_row(diagonals)
  end

  def matches_in_horizontal(dna)
    sum_matches_in_row(dna)
  end
end
