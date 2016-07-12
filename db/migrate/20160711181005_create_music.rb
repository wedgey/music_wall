class CreateMusic < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :title
      t.string :author
      t.string :url
      t.timestamps
    end
  end
end
