class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, -> { order :created_at }, dependent: :destroy
  acts_as_list scope: :project

  validates :name,
    presence: true,
    length: { maximum: 160 }
end
