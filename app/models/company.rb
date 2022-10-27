class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :users, dependent: :destroy
  has_many :quotes, dependent: :destroy
  
  before_create :set_oid
  after_create :update_token

  private

  attr_accessor :token

  def set_oid
    return if oid.present?

    self.token = Token.available_for_company.first
    self.oid   = ["c_", token.token].join
  end

  def update_token
    return unless token

    token.update(available_for_company: false)
  end
end
