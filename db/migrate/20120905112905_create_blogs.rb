class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.date :published_at
      t.text :content
      t.integer :author_id
      t.string :permalink

      t.timestamps
    end
  end
end
