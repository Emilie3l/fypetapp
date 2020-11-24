class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :address
      t.date :date
      t.string :status
      t.boolean :reward_offered
      t.integer :reward_amount

      t.timestamps
    end
  end
end
