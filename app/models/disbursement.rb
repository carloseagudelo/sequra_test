class Disbursement < ApplicationRecord

  belongs_to :order

  has_one :merchant, through: :order
  has_one :shopper, through: :order

  validates :amount, :percentage, presence: true
  validates_uniqueness_of :order_id, message: "This order has been disbursed before"

  scope :by_merchant, lambda { |merchant_id|
    return if merchant_id.nil?
    joins(:order).where("orders.merchant_id = ?", merchant_id)
  }

  scope :by_dates, lambda { |from, to|
    joins(:order).where("orders.completed_at between ? and ?", from, to)
  }

end
