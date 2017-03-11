class AddProblemToTestCases < ActiveRecord::Migration[5.0]
  def change
    add_reference :test_cases, :problem, foreign_key: true
  end
end
