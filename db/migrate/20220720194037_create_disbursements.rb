class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.references :order, null: false, foreign_key: true
      t.float :amount
      t.float :percentage

      t.timestamps
    end
  end
end
