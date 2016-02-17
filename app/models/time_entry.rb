class TimeEntry < ApplicationRecord
  belongs_to :project

  validates :started_at, presence: true
  validate :stopped_greater_than_started

  def duration
    self.stopped_at - self.started_at
  end

  def running?
    self.stopped_at.blank?
  end

  private
  def stopped_greater_than_started
    errors.add('Stopped at date', 'must be greater than started at') unless self.started_at.present? &&
        self.stopped_at > self.started_at
  end
end
