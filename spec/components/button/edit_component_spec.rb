# frozen_string_literal: true

require "rails_helper"

RSpec.describe Button::EditComponent, type: :component do
  subject(:component) { described_class.new(link_path: link_path) }

  let(:link_path) { "/path" }
  
  it "renders a link to edit a record " do
    render_inline(component)

    expect(page).to have_css("a[class='btn btn--light']")
    expect(page).to have_selector("a[href='#{link_path}']")
    expect(page.find("a")).to have_content("Edit")
  end
end
