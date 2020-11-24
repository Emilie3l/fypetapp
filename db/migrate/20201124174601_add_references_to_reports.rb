class AddReferencesToReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :user, null: false, foreign_key: true
    add_reference :reports, :pet, null: false, foreign_key: true
  end
end
