class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name

  has_one :company, serializer: CompanySerializer
end
