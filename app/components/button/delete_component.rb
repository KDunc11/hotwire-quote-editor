# frozen_string_literal: true

class Button::DeleteComponent < ViewComponent::Base
  attr_accessor :link_path

  def initialize(link_path:)
    @link_path = link_path
  end
end
