class BlogArticle < ActiveRecord::Base
  attr_accessible :author_id, :content, :online, :title

  belongs_to :author, :class_name => 'User'
end
