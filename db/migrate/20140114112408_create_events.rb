class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.boolean :all_day
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :class_name
      t.boolean :editable
      t.boolean :start_editable
      t.boolean :duration_editable
      t.string :color
      t.string :background_color
      t.string :border_color
      t.string :text_color 
    end
  end
end