class AddAttachmentTestcaseTestcaseOutputToTestCases < ActiveRecord::Migration
  def self.up
    change_table :test_cases do |t|
      t.attachment :testcase
      t.attachment :testcase_output
    end
  end

  def self.down
    remove_attachment :test_cases, :testcase
    remove_attachment :test_cases, :testcase_output
  end
end
