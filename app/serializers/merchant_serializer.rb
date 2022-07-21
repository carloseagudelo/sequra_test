class MerchantSerializer < ActiveModel::Serializer
  attributes :id,
              :name,
              :email,
              :cif

  def files
    object.files.map { |file| FileSerializer.new(file).attributes }
  end
end