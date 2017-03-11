class Problem < ApplicationRecord
  has_many :submissions, dependent: :destroy, inverse_of: :problem
  has_many :test_cases, dependent: :destroy, inverse_of: :problem

  accepts_nested_attributes_for :test_cases, allow_destroy: true

  scope :by_pcode, ->(pcode) { where(pcode: pcode) }
  validates_presence_of :pcode
end
