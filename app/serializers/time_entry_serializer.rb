class TimeEntrySerializer < ActiveModel::Serializer
  attributes :id, :manual, :started_at, :stopped_at, :duration
end
