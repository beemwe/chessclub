class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.string :title
      t.boolean :online
      t.integer :author_id
      t.text :content

      t.timestamps
    end
  end
end
