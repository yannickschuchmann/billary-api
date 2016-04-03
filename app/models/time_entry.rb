class TimeEntry < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  before_validation :set_started_at
  before_validation :round_dates, if: "stopped_at.present?"
  before_create :stop_all_others, unless: "stopped_at.present?"

  validates :started_at, presence: true
  validate :stopped_greater_than_started, if: "stopped_at.present?"

  def duration
    if self.stopped_at.present?
      self.round_dates # set this even when self is not saved yet.
      return ((self.stopped_at - self.started_at) / 60).ceil
    else
      return 0
    end
  end

  def running?
    self.stopped_at.blank?
  end

  def self.stop_all
    TimeEntry.all.where(stopped_at: nil).update_all(stopped_at: Time.now)
  end

  def round_dates
    duration = ((self.stopped_at - self.started_at) / 60).ceil

    self.started_at = self.started_at.beginning_of_minute
    self.stopped_at = self.started_at + duration.minutes
  end

  private
  def set_started_at
    self.started_at = Time.now if self.started_at.blank?
  end


  def stop_all_others
    TimeEntry.stop_all
  end

  def stopped_greater_than_started
    unless self.started_at.present? && self.stopped_at > self.started_at
      errors.add('Stopped at date', 'must be greater than started at')
    end
  end
end
