class EditReviewStars < ActiveRecord::Migration
  change_column :reviews, :stars, :decimal
end
