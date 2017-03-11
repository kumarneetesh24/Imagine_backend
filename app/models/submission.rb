class Submission < ApplicationRecord
  belongs_to :problem, counter_cache: true, inverse_of: :submissions

  scope :by_id, -> (id){ where(id: id)   }

  after_create :create_submission_data
  before_destroy :delete_submission_data

  def create_submission_data
    problem = self.problem
    system 'mkdir', '-p', "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:id]}"
    puts "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:id]}"
    user_source_code = File.open("#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:id]}/user_source_code.cpp", 'w')
    user_source_code.write(self[:user_source_code])
    user_source_code.close
    problem.test_cases.each do |test_case|
      system 'mkdir', '-p', "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:id]}/#{test_case[:name]}"
    end
    true
  end

  def delete_submission_data
    problem = self.problem
    system 'rm', '-rf', "#{CONFIG[:base_path]}/submit/#{problem[:pcode]}/#{self[:id]}"
    true
  end
end
