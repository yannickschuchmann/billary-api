class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :child_ids, :parent_id

  # has_many :children, serializer: self
  has_many :time_entries, serializer: TimeEntrySerializer
  # belongs_to :parent, serializer: ParentSerializer
end
