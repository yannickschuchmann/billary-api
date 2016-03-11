class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :child_ids, :parent_id

  has_many :time_entries, serializer: TimeEntrySerializer
end
