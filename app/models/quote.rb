class Quote < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  before_create :set_oid
  before_create :update_token

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
