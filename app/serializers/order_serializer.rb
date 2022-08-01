class OrderSerializer < ActiveModel::Serializer
  attributes :id,
             :amount,
             :completed_at

  def completed_at
    object.completed_at.strftime('%d-%m-%Y %H:%M %p')
  end
end