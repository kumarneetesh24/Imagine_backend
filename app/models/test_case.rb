class TestCase < ApplicationRecord
  has_attached_file :testcase
  has_attached_file :testcase_output
  do_not_validate_attachment_file_type :testcase
  do_not_validate_attachment_file_type :testcase_output

  belongs_to :problem, inverse_of: :test_cases


  before_create :create_test_data
  after_destroy :delete_test_data

  def to_s
    name
  end

  def title
    to_s
  end

  def create_test_data
    problem = self.problem
    system 'mkdir', '-p', "#{CONFIG[:base_path]}/problems/#{problem[:pcode]}/#{self[:name]}"
    testcase = File.open("#{CONFIG[:base_path]}/problems/#{problem[:pcode]}/#{self[:name]}/testcase", 'w')
    testcase.write(Paperclip.io_adapters.for(self.testcase).read)
    testcase.close
    testcase_output = File.open("#{CONFIG[:base_path]}/problems/#{problem[:pcode]}/#{self[:name]}/testcase_output", 'w')
    testcase_output.write(Paperclip.io_adapters.for(self.testcase_output).read)
    testcase_output.close
    true
  end

  def delete_test_data
    problem = self.problem
    system 'rm', '-rf', "#{CONFIG[:base_path]}/problems/#{problem[:pcode]}/#{self[:name]}"
    true
  end
end
