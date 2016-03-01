class Project < ApplicationRecord
  belongs_to :parent, class_name: "Project", optional: true
  has_many :children, foreign_key: "parent_id", dependent: :destroy, class_name: "Project"
  has_many :time_entries, dependent: :destroy

  validates :name, presence: true

  def count_all_children(project = self, sum = 0)
    project.children.each do |child|
      sum += 1
      sum = count_all_children(child, sum)
    end
    return sum
  end

end