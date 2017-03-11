class AddSubmissionsCountToProblems < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :submissions_count, :integer
  end
end
