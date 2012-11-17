class AddSlugToBlogs < ActiveRecord::Migration
  def change
    add_column :blog_posts, :slug, :string
    add_index :blogs, :slug
  end
end
