class RemoveColumnsFromEvents < ActiveRecord::Migration
  def change
     remove_column :events, :location, :string
  end
end
