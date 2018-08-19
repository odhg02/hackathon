class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.text :career
      t.string :grade
      t.text :introduction
      t.references :mypage, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
