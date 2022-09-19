# frozen_string_literal: true

class Button::NewComponent < ViewComponent::Base
  attr_accessor :link_path, :klass

  def initialize(link_path:, klass:)
    super
    @link_path = link_path
    @klass = klass
  end
end
