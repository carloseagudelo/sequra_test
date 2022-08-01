Rake::Task["db:populate:merchants"].execute
Rake::Task["db:populate:shoppers"].execute
Rake::Task["db:populate:orders"].execute

Order.where.not(completed_at: nil).each do |order|
  order.disburse!
end