class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :email
      t.string :name
      t.float :amount
      t.string :paymill_id
      t.string :paymill_card_token
      t.timestamps
    end
  end
end
