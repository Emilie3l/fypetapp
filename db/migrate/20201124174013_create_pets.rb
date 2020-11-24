class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.string :size
      t.string :color
      t.string :gender
      t.integer :age
      t.string :traits

      t.timestamps
    end
  end
end
