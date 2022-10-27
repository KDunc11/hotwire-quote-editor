# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :company

  scope :ordered, -> { order(id: :desc) }

  before_create :set_oid
  after_create :update_token

  # rubocop:disable Metrics/LineLength
  # after_create_commit -> { broadcast_prepend_to "quotes", html: ApplicationController.render(QuoteComponent.new(quote: self)) }
  # after_update_commit -> { broadcast_replace_to "quotes", html: ApplicationController.render(QuoteComponent.new(quote: self)) }
  # after_destroy_commit -> { broadcast_replace_to "quotes", html: ApplicationController.render(QuoteComponent.new(quote: self)) }
  # rubocop:enable Metrics/LineLength

  # The following is the same as the 3 lines above
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

  private

  attr_accessor :token

  def set_oid
    return if oid.present?

    self.token = Token.available_for_quote.first
    self.oid   = ["q_", StringId.new.generate].join
  end

  def update_token
    return unless token

    token.update(available_for_quote: false)
  end
end
