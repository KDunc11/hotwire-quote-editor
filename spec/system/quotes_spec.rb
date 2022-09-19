# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Quotes", type: :system do
  let(:quote) { create(:quote) }

  before do
    quote
  end

  it "creates a new quote" do
    visit quotes_path
    expect(page).to have_selector("h1")
    expect(page.find("h1")).to have_text("Quotes")

    click_on "New Quote"

    fill_in "Name", with: "Capybara quote"
    click_on "Create quote"

    expect(page).to have_selector("h1")
    expect(page.find("h1")).to have_text("Quotes")

    new_quote = Quote.last
    expect(page).to have_selector("a[href='#{quote_path(new_quote.oid)}']")
    expect(page.all("a[href='#{quote_path(new_quote.oid)}']").first).to have_text("Capybara quote")
  end

  it "shows a quote" do
    visit quotes_path
    click_link quote.name

    assert_selector "h1", text: quote.name
  end

  it "updates a quote" do
    visit quotes_path
    expect(page).to have_selector("h1")
    expect(page.find("h1")).to have_text("Quotes")

    click_on "Edit", match: :first
    fill_in "Name", with: "Updated quote"

    # TODO: Fix this from navigating to edit page as opposed to replacing turbo frame
    # expect(page).to have_selector("h1")
    # expect(page.find("h1")).to have_text("Quotes")
    click_on "Update quote"

    expect(page).to have_selector("h1")
    expect(page.find("h1")).to have_text("Quotes")
    expect(page).to have_text("Updated quote")
  end

  it "destroys a quote" do
    visit quotes_path
    expect(page).to have_text(quote.name)

    click_on "Delete", match: :first
    expect(page).not_to have_text(quote.name)
  end
end
