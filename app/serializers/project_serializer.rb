class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :child_ids, :parent_id, :client_id
  attribute :duration_of_open_time_entries, key: :open_duration

  has_many :time_entries, serializer: TimeEntrySerializer
  belongs_to :client, serializer: ClientSerializer
end
