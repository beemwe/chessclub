class TournamentPlayer < ActiveRecord::Base
  attr_accessible :dwz, :first_name, :last_name, :fide_title

  belongs_to :tournament

  validates_presence_of :last_name, :first_name
end
