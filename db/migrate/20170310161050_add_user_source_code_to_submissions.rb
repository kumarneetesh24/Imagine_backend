class AddUserSourceCodeToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :user_source_code, :string
  end
end
