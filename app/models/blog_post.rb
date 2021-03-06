class BlogPost < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :blog_post_files, dependent: :destroy

  resourcify

  opinio_subjectum

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  attr_accessible :author_id, :content, :permalink, :published_at, :title, :subtitle, :slug

  validates_presence_of :title

  def self.recent
    BlogPost.where('published_at IS NOT NULL').order('created_at DESC, published_at DESC').limit(7)
  end

  def self.for_index(user)
    if user.present? && user.can?(:mangage, BlogPost)
      result = BlogPost.order('created_at DESC')
    else
      result = BlogPost.where('published_at IS NOT NULL').order('published_at DESC')
    end
    result
  end

end
