# encoding: utf-8
class League < ActiveRecord::Base
  attr_accessible :age_limit, :boards, :girls_only, :name, :scraper_link, :subs_bench

  acts_as_tree

  CLUBNAME = "TuS Fürstenfeldbruck"

  def generate_team_name
    addition = ""

    use_age_limit = self.age_limit || 0
    if use_age_limit == 0
      addition = self.girls_only? ? ' Damen' : ''
    elsif use_age_limit > 30
      addition = self.girls_only? ? 'Seniorinnen' : 'Senioren'
    elsif use_age_limit < 21
      addition = "U#{age_limit}#{self.girls_only? ? ' Mädchen' : ''}"
    end

    "#{CLUBNAME}#{addition}"
  end
end
