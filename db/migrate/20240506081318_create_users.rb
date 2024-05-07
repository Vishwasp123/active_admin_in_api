class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
     t.string :name
     t.string :username
     t.string :email
     t.string :password_digest
     t.belongs_to :role
     t.string :status

     t.timestamps
   end
 end
end
