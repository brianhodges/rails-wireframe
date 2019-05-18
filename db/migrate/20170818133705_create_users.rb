class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, default: "", null: false
      t.string :password_hash, default: "", null: false
      t.string :password_salt, default: "", null: false
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
