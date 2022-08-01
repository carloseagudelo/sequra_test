require 'csv'

namespace :db do
  namespace :populate do
    task merchants: :environment do
      file = Rails.root.join('lib/tasks/data/merchants.csv')
      CSV.foreach(file) do |row|
        Merchant.create!(
          id:    row[0],
          name:  row[1],
          email: row[2],
          cif:   row[3]
        )
      end
    end

    task shoppers: :environment do
      file = Rails.root.join('lib/tasks/data/shoppers.csv')
      CSV.foreach(file) do |row|
        Shopper.create!(
          id:    row[0],
          name:  row[1],
          email: row[2],
          nif:   row[3]
        )
      end
    end

    task orders: :environment do
      file = Rails.root.join('lib/tasks/data/orders.csv')
      CSV.foreach(file) do |row|
        Order.create!(
          id:           row[0],
          merchant_id:  row[1],
          shopper_id:   row[2],
          amount:       row[3],
          completed_at: DateTime.parse(row[4])
        )
      end
    end
  end
end
