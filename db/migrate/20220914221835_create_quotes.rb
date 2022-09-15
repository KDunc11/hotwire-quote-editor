class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :oid, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :quotes, :oid, unique: true
    add_index :quotes, :name, unique: true
  end
end
