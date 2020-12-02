class AddReunitedToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :reunited, :boolean
  end
end
