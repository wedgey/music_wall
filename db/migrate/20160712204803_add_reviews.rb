class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :music
      t.references :user
      t.string :review
      t.timestamps
    end
  end
end
