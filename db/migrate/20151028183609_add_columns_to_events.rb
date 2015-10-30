class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address, :string
    add_column :events, :price, :string
    add_column :events, :start, :time
    add_column :events, :end, :time
    add_column :events, :capacity, :integer
    add_column :events, :category, :string
    add_column :events, :description, :text
    add_column :events, :county, :string
  end
end
