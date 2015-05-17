class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  validates :name,
    presence: true,
    length: { maximum: 160 }

  def as_json(options = {})
    super({ include: [:tasks] })
  end
end
