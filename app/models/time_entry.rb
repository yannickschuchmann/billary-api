class TimeEntry < ApplicationRecord
  belongs_to :project

  before_validation :set_started_at

  validates :started_at, presence: true
  validate :stopped_greater_than_started, if: "stopped_at.present?"

  def duration
    if self.stopped_at.present?
      return self.stopped_at - self.started_at
    else
      return 0
    end
  end

  def running?
    self.stopped_at.blank?
  end

  private
  def set_started_at
    self.started_at = Time.now if self.started_at.blank?
  end

  def stopped_greater_than_started
    errors.add('Stopped at date', 'must be greater than started at') unless self.started_at.present? &&
        self.stopped_at > self.started_at
  end
end
