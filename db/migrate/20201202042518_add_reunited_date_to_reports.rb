class AddReunitedDateToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :reunited_date, :date
  end
end
