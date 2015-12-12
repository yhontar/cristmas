class CreateUserAuthorizations < ActiveRecord::Migration
  def change
    create_table :user_authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :user_authorizations, :user_id
    add_index :user_authorizations, :uid
  end
end
