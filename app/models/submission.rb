class Submission < ApplicationRecord
  belongs_to :problem, counter_cache: true
end
