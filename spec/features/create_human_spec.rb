require 'rails_helper'

RSpec.describe 'Creating a human', type: :feature do
  scenario 'User creates a human' do
    click_on 'New Human'
    expect(page).to have_content('Humans')
    fill_in 'Name', with: 'John Doe'

    click_on 'Create Human'
    visit humans_path
    expect(page).to have_content('John Doe')
  end
end
