# frozen_string_literal: true

class Button::EditComponent < ViewComponent::Base
  attr_accessor :link_path

  def initialize(link_path:)
    @link_path = link_path
  end
end
