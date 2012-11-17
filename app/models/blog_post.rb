class BlogPost < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  attr_accessible :author_id, :content, :permalink, :published_at, :title, :subtitle, :slug

  validates_presence_of :title

  def self.recent
    BlogPost.where('published_at IS NOT NULL').order('created_at DESC, published_at DESC').limit(4)
  end
end
