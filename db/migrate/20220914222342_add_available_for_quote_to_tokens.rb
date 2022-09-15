class AddAvailableForQuoteToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :available_for_quote, :boolean, default: true
    add_index :tokens, :available_for_quote
  end
end
