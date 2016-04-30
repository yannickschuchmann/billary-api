class TimeEntry < ApplicationRecord
  scope :open, -> {where(:invoice_id => nil).where.not(:stopped_at => nil)}
  scope :invoiced, -> {where.not(:invoice_id => nil)}

  default_scope -> {order(:started_at)}

  belongs_to :project, optional: false
  belongs_to :user, optional: false
  belongs_to :invoice, optional: true

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

  def self.stop_all user_id
    TimeEntry.all.where(stopped_at: nil, user_id: user_id).each do |entry|
      entry.stopped_at = Time.now
      entry.save
    end
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
    TimeEntry.stop_all self.user_id
  end

  def stopped_greater_than_started
    unless self.started_at.present? && self.stopped_at > self.started_at
      errors.add('Stopped at date', 'must be greater than started at')
    end
  end
end
