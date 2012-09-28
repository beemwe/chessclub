class AddPropsToEventSeries < ActiveRecord::Migration
  def change
    add_column :event_series, :owner_id, :integer
    add_column :event_series, :category, :string
    add_column :event_series, :place, :string
  end
end
