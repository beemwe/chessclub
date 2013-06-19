class BlogPostFile < ActiveRecord::Base
  attr_accessible :attachment

  belongs_to :blog_post
  has_attached_file :attachment, styles: {thumb: '280x210>', slideshow: '1000x760>'}
end
