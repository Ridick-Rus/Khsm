require 'rails_helper'

RSpec.feature 'user views other profile', type: :feature do
  let!(:first_user) { FactoryGirl.create(:user, name: 'Андрей') }
  let(:second_user) { FactoryGirl.create(:user) }
  let!(:games) do
    [
      FactoryGirl.create(
        :game,
        user_id: first_user.id,
        is_failed: false,
        current_level: 4,
        prize: 5000,
        created_at: Time.parse('2023.03.23, 19:00'),
        finished_at: Time.parse('2023.03.23, 19:10')
      ),
      FactoryGirl.create(
        :game,
        user_id: first_user.id,
        is_failed: true,
        current_level: 8,
        prize: 22000,
        created_at: Time.parse('2023.03.23, 23:00'),
        finished_at: Time.parse('2023.03.23, 23:22')
      )
    ]
  end

  before { login_as second_user }

  scenario 'success' do
    visit user_path(first_user)
    save_and_open_page

    expect(page).to have_content('Андрей')
    expect(page).to have_content('проигрыш')
    expect(page).to have_content('деньги')
    expect(page).to have_content('23 марта, 19:00')
    expect(page).to have_content('23 марта, 23:00')
    expect(page).not_to have_content('Сменить имя и пароль')
    expect(page).to have_content('22 000 ₽')
    expect(page).to have_content('5 000 ₽')
    expect(page).to have_content('50/50')
    expect(page).to have_content('4')
    expect(page).to have_content('8')
  end
end
