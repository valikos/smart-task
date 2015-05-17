class Task < ActiveRecord::Base
  belongs_to :project
  acts_as_list scope: :project
end
