class CreateMatchings < ActiveRecord::Migration
  def change
    create_table :matchings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.string :supply
      t.integer :status

      t.timestamps null: false
    end
  end
end
