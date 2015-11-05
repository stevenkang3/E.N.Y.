class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
        t.string :first_name
        t.string :last_name
        t.string :email
        t.string :key
        t.string :password_digest
      t.timestamps
    end
  end
end
