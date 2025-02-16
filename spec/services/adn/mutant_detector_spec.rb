require 'rails_helper'

describe Services::Adn::MutantDetector do
  let(:service) { Services::Adn::MutantDetector }

  describe '#call' do
    context 'when the dna is empty' do
      let(:dna) { [] }

      it 'returns false' do
        expect(service.call(dna)).to be_falsey
      end
    end

    context 'when the dna is mutant' do
      let(:dna) { %w[ATGCGA
                     CAGTGC
                     TTATGT
                     AGAAGG
                     CCCCTA
                     TCACTG] }

      it 'returns true' do
        expect(service.call(dna)).to be_truthy
      end
    end

    context 'when the dna contains only one horizontal' do
      let(:dna) { %w[AGAATT
                     CAGTGC
                     TTGTGT
                     AGAAGG
                     CCCCTA
                     TCACTG] }

      it 'returns true' do
        expect(service.call(dna)).to be_truthy
      end
    end

    context 'when the dna contains only one diagonal' do
      let(:dna) { %w[AGAATT
                     CAGTGC
                     TGTTGT
                     ATAAGG
                     CTCCTA
                     TCACTG] }
      it 'returns true' do
        expect(service.call(dna)).to be_truthy
      end
    end

     context 'when the dna contains only one vertical' do
      let(:dna) { %w[AGAATG
                     CAGTGG
                     TTGTGG
                     ATAAGG
                     CTCCTA
                     TCACTG] }
      it 'returns true' do
        expect(service.call(dna)).to be_truthy
      end
    end

    context 'when the dna is not mutant' do
      let(:dna) { %w[ATGCGA CAGTGC TTATTT AGACGG GCGTCA TCACTG] }

      it 'returns false' do
        expect(service.call(dna)).to be_falsey
      end
    end
  end
end
