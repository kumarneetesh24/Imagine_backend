class Problem < ApplicationRecord
  has_many :submissions, dependent: :destroy
end
