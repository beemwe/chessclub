class RenameBlogToBlogPost < ActiveRecord::Migration
  def up
    rename_table :blogs, :blog_posts
  end

  def down
    rename_table :blog_posts, :blogs
  end
end
