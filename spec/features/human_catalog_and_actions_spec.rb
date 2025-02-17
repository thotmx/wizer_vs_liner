require 'rails_helper'

RSpec.describe 'Creating a human', type: :feature do
  scenario 'User creates a human' do
    visit root_path
    click_on 'Create a new human'
    expect(page).to have_content('Human Catalog')
    expect(page).to have_content('Creating a human')
    fill_in 'Name', with: 'John Doe'
    click_on 'Create Human'
    visit humans_path
    expect(page).to have_content('John Doe')
    expect(page).to have_content('mutant')
  end

  scenario 'User edit already created human' do
    Human.create(name: 'John Doe', human_type: 'mutant', dna: "AAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA")
    visit root_path
    click_on 'Alter human'
    expect(page).to have_content('Human Catalog')
    expect(page).to have_content('Altering this human')
    fill_in 'Name', with: 'John Wick'
    click_on 'Update Human'
    visit humans_path
    expect(page).to have_content('John Wick')
    expect(page).to have_content('mutant')
  end

  scenario 'User destroy already created human' do
    Human.create(name: 'John Doe', human_type: 'mutant', dna: "AAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA\nAAAAAA")
    visit root_path
    click_on 'Destroy human'
    visit humans_path
    expect(page).not_to have_content('John Doe')
    expect(page).not_to have_content('mutant')
  end
end
