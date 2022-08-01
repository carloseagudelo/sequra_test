class Payment < ApplicationRecord
  belongs_to :order

  after_create :complete_payments

  def complete_payments
    return unless order.completed?
    order.update(completed_at: self.made_at)
  end

end
