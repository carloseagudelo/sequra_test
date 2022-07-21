class DisbursementSerializer < ActiveModel::Serializer
  attributes :id,
             :amount,
             :percentage
             belongs_to :order
             has_one :merchant
end