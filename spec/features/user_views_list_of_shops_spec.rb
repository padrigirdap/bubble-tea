require 'rails_helper'

feature "visitor sees a list of shops" do
  let!(:user) { FactoryGirl.create(:user) }

  let!(:bubblicious) do
    Shop.create(
      name: "Bubblicious",
      address: "33 Harrison Ave",
      city: "Boston",
      state: "MA",
      zip: "02111",
      description: "Straightforward Bubble Tea for a great price."
    )
  end

  let!(:tapioca_town) do
    Shop.create(
      name: "Tapioca Town",
      address: "Beach streer",
      city: "Boston",
      state: "MA",
      zip: "02112"
    )
  end

  scenario "user visits root path and sees list of shops" do
    visit root_path

    expect(page).to have_content(bubblicious.name)
    expect(page).to have_content(tapioca_town.name)
  end

  scenario "sees a list of shops from shops path and link for new shop" do
    visit shops_path

    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_link bubblicious.name
    expect(page).to have_link tapioca_town.name

    first(:link, "Add New Shop").click

    expect(page).to have_content "Add a Shop Location"
  end

  scenario "clicks link and is taken to show page for given shop" do
    visit shops_path

    click_link "Bubblicious"

    expect(page).to have_current_path(shop_path(bubblicious))
  end
end
