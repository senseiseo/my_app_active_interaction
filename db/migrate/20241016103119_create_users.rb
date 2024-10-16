class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :patronymic
      t.string :email, null: false
      t.integer :age, null: false
      t.string :nationality
      t.string :country
      t.string :gender, null: false
      t.string :full_name

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
