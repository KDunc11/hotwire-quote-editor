class Token < ApplicationRecord
  validates :token, presence: true, uniqueness: true

  scope :available_for_quote, -> { where(available_for_quote: true) }
end
