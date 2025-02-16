module Services
  module Adn
    class MutantDetector
      def call(dna)
        return false if dna.empty?

        return true if number_of_matches(dna) >= 1

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
        row.scan(/(A{4}|T{4}|C{4}|G{4})/).count
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
            diagonals << (0..3).map { |x| dna[i + x][j + x] if i + x < dna.size && j + x < dna.size }.join
            diagonals << (0..3).map { |x| dna[i - x][j + x] if i - x >= 0 && j + x < dna.size }.join
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
  end
end
