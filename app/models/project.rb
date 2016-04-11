class Project < ApplicationRecord
  belongs_to :user
  belongs_to :client, optional: true
  belongs_to :parent, class_name: "Project", optional: true
  has_many :children, foreign_key: "parent_id", dependent: :destroy, class_name: "Project"
  has_many :time_entries, dependent: :destroy

  default_scope { order('created_at DESC') }
  scope :top_level, -> {where(:parent_id => nil)}

  validates :name, presence: true

  def count_all_children(project = self, sum = 0)
    project.children.each do |child|
      sum += 1
      sum = count_all_children(child, sum)
    end
    return sum
  end

  def duration(project = self, sum = 0)
    project.time_entries.each do |time_entry|
      sum += time_entry.duration
    end
    project.children.each do |child|
      sum = duration(child, sum)
    end
    return sum
  end
end