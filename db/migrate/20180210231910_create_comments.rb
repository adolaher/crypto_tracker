class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :title, null: false
      t.integer :rating, null: false
      t.text :value
      t.text :body
      t.text :date
      t.integer :initial_coin_deposit
      t.bigint "user_id"
      t.belongs_to :coin
      t.timestamps
    end
  end
end
