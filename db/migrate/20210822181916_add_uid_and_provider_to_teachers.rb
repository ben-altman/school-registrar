class AddUidAndProviderToTeachers < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :uid, :string
    add_column :teachers, :provider, :string
  end
end
