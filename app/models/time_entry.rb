class TimeEntry < ApplicationRecord
  belongs_to :project
  def duration
    self.stopped_at - self.started_at
  end

  def running?
    self.stopped_at.blank?
  end
end
