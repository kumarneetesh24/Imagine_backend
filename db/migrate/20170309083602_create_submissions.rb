class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.string :status_code, default: 'PE'
      t.references :problem, foreign_key: true
      t.timestamps
    end
  end
end
