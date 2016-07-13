class AddReviewStars < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.integer :stars
    end
  end
end
