class Problem < ApplicationRecord
  has_many :submissions, dependent: :destroy
  has_many :test_cases, dependent: :destroy

  scope :by_pcode, ->(pcode) { where(pcode: pcode) }
  validates_presence_of :pcode
end
