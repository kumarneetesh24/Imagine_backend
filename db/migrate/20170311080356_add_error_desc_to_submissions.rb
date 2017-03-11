class AddErrorDescToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :error_desc, :string
  end
end
