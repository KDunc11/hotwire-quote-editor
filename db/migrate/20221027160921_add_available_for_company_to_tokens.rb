class AddAvailableForCompanyToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :available_for_company, :boolean, default: true, null: false
    add_index :tokens, :available_for_company
  end
end
