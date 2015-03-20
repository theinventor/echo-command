class CreateLightSwitches < ActiveRecord::Migration
  def change
    create_table :light_switches do |t|
      t.integer :user_id
      t.string :name
      t.boolean :turn_off, default: true
      t.boolean :turn_on, default: true

      t.timestamps null: false
    end
  end
end
