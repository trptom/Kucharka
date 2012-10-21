class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.primary_key :id
      t.string :userName
      t.string :login
      t.string :password
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
