class CreateIndex < ActiveRecord::Migration
  def change
    add_index :youtube_data, :published_at
  end
end
