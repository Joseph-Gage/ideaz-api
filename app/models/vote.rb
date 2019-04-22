class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  validates_presence_of :value, :user, :idea
  validates_inclusion_of :value, in: [-1, 1], message: 'can only be -1 or 1'
end
