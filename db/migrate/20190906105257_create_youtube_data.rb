class CreateYoutubeData < ActiveRecord::Migration
  def change
    create_table :youtube_data do |t|
      t.string :video_id, null: false
      t.string :title, null: false
      t.string :description
      t.string :thumbnail_url
      t.integer :published_at
      t.integer :fetched_at

      t.timestamps
    end
  end
end
