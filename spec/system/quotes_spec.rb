require "rails_helper"

RSpec.describe "Quotes", type: :system do
  let(:quote) { create(:quote) }

  before do
    quote
  end

  it "creates a new quote" do
    # When we visit the Quotes#index page
    # we expect to see a title with the text "Quotes"
    visit quotes_path
    expect(page).to have_selector("h1")
    expect(page.find("h1")).to have_text("Quotes")

    # When we click on the link with the text "New Quote"
    # we expect to land on a page with the text "New Quote"
    click_on "New Quote"
    expect(page).to have_selector("h1")
    expect(page.find("h1")).to have_text("New Quote")

    # When we fill in the name input with "Capybara quote"
    # and we click on "Create Quote"
    fill_in "Name", with: "Capybara quote"
    click_on "Create quote"

    # We expect to be back on the page with the title "Quotes"
    # and to see our "Capybara quore" added to the list
    new_quote = Quote.last
    expect(page).to have_selector("a[href='#{quote_path(new_quote.oid)}']")
    expect(page.find("a[href='#{quote_path(new_quote.oid)}']")).to have_text("Capybara quote")
  end

  it "shows a quote" do
    visit quotes_path
    click_link quote.name

    assert_selector "h1", text: quote.name
  end

  it "updates a quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit Quote"

    fill_in "Name", with: "Updated quote"
    click_on "Update quote"

    assert_selector "h1", text: "Quotes"
    expect(page).to have_text("Updated quote")
  end

  it "destroys a quote" do
    visit quotes_path
    expect(page).to have_text(quote.name)

    click_on "Delete", match: :first
    expect(page).not_to have_text(quote.name)
  end
end
