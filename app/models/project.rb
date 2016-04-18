class Project < ApplicationRecord
  default_scope { order('created_at DESC') }
  scope :top_level, -> {where(:parent_id => nil)}

  belongs_to :user
  belongs_to :client, optional: true
  belongs_to :parent, class_name: "Project", optional: true
  has_many :children, foreign_key: "parent_id", dependent: :destroy, class_name: "Project"
  has_many :time_entries, dependent: :destroy
  has_many :invoice_line_items, dependent: :destroy
  has_many :invoices, through: :invoice_line_items

  validates :name, presence: true

  def count_all_children(project = self, sum = 0)
    project.children.each do |child|
      sum += 1
      sum = count_all_children(child, sum)
    end
    return sum
  end

  def duration(open = false, project = self, sum = 0)
    entries = open ? project.time_entries.open : project.time_entries
    entries.each do |time_entry|
      sum += time_entry.duration
    end
    project.children.each do |child|
      sum = duration(open, child, sum)
    end
    return sum
  end

  def duration_of_open_time_entries
    self.duration(true)
  end

  def mark_open_time_entries_as_invoiced(project = self)
    project.time_entries.open.update_all(invoiced: true)
    project.children.each do |child|
      child.mark_open_time_entries_as_invoiced
    end
  end

end