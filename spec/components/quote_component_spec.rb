require "rails_helper"

RSpec.describe QuoteComponent, type: :component do
  subject(:component) { described_class.new(quote: quote) }

  let(:quote) { build_stubbed(:quote) }

  it "renders a quote" do
    render_inline(component)

    expect(page).to have_css("div[class='quote']")
    expect(page.find("div[class='quote']")).to have_content(quote.name)
    expect(page).to have_selector("a[href='#{quote_path(quote.oid)}']")
    expect(page).to have_css("div[class='quote__actions']")
    expect(page.find("div[class='quote__actions']")).to have_content("Edit")
    expect(page.find("div[class='quote__actions']")).to have_content("Delete")
  end
end