class Address < ApplicationRecord
  belongs_to :client, optional: true
end
