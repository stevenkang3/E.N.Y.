class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.string :location
      t.string :state
      t.string :host
      t.references :user, index: true

      t.timestamps
    end
  end
end
