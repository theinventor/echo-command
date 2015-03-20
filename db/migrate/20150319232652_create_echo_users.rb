class CreateEchoUsers < ActiveRecord::Migration
  def change
    create_table :echo_users do |t|
      t.string :device_id
      t.integer :authentication_id
      t.string :registration_code

      t.timestamps null: false
    end
  end
end
