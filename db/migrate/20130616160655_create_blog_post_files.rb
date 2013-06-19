class CreateBlogPostFiles < ActiveRecord::Migration
  def change
    create_table :blog_post_files do |t|
      t.integer :blog_post_id
      t.string :attachment_uid
      t.string :attachment_file_name

      t.timestamps
    end
  end
end
