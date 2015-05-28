class Comment < ActiveRecord::Base
  belongs_to :task

  validates :content,
    presence: true,
    length: { maximum: 160 }
end
