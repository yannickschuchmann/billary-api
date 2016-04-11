class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :child_ids, :parent_id, :client_id

  has_many :time_entries, serializer: TimeEntrySerializer
  belongs_to :client, serializer: ClientSerializer
end
