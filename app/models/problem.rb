class Problem < ApplicationRecord
  has_many :submissions, dependent: :destroy

  validates_presence_of :pcode
end
