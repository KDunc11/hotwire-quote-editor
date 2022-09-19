# frozen_string_literal: true

class QuoteComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_accessor :quote

  def initialize(quote:)
    super
    @quote = quote
  end
end
