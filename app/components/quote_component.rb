# frozen_string_literal: true

class QuoteComponent < ViewComponent::Base
  attr_accessor :quote

  def initialize(quote:)
    @quote = quote
  end
end
