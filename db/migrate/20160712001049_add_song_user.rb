class AddSongUser < ActiveRecord::Migration
  def change
    change_table :musics do |t|
      t.references :user
    end

    create_table :votes do |t|
      t.references :user
      t.references :music 
    end
  end
end
