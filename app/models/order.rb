class Order < ApplicationRecord

  belongs_to :merchant
  belongs_to :shopper

  has_one :disbursement

  has_many :payments

  validates :amount, presence: true

  def disburse!
    Disbursement.create!(order_id: self.id, amount: amount_calculate(disburse_percentage), percentage: disburse_percentage)
  end

  class << self
    def to_disburse(merchant_id, from, to)
      return where("merchant_id = ? and completed_at between ? and ?", merchant_id, from, to) if merchant_id.present?
      where("completed_at between ? and ?", from, to)
      #TODO using right join would only bring orders no disbursed before but SQLite don't allow 'right join'
    end
  end

  def completed?
    return true if completed_at.present?
    payments.sum{ |payment| payment.amount } == amount
  end

  def disbursed?
    disbursement.present?
  end

  private

  def disburse_percentage
    if amount < 50
      DISBUSERMENT_PERCENTAGES[:smaller]
    elsif amount > 300
      DISBUSERMENT_PERCENTAGES[:highest]
    else
      DISBUSERMENT_PERCENTAGES[:medium]
    end
  end

  def amount_calculate(percentage)
    amount * percentage
  end

end
