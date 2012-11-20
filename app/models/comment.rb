class Comment < ActiveRecord::Base
  opinio

  Opinio::set_destroy_conditions do |comment|
    comment.owner == current_user
  end
end
