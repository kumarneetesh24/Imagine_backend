class CreateProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :problems do |t|
      t.string :pname
      t.string :pcode
      t.string :statement
      t.boolean :state
      t.timestamps
    end
  end
end
