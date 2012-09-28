class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  attr_accessible :author_id, :content, :permalink, :published_at, :title, :subtitle, :slug

  validates_presence_of :title

  def self.recent
    Blog.where{published_at.blank? == false}.limit(4).order('created_at DESC, published_at DESC')
  end
end
