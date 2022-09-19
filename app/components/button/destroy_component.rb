# frozen_string_literal: true

class Button::DestroyComponent < ViewComponent::Base
  attr_accessor :link_path

  def initialize(link_path:)
    super
    @link_path = link_path
  end
end
