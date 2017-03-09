class CreateProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :problems do |t|

      t.timestamps
    end
  end
end
