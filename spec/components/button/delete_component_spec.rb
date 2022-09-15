require "rails_helper"

RSpec.describe Button::DeleteComponent, type: :component do
  subject(:component) { described_class.new(link_path: link_path) }

  let(:link_path) { "/path" }

  it "render a button to delete a record" do
    render_inline(component)

    expect(page).to have_css("button[class='btn btn--light']")
    expect(page.find("button")).to have_content("Delete")
  end
end