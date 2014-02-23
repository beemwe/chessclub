# encoding: utf-8
class Combat < ActiveRecord::Base
  attr_accessible :league_id, :home_team_id, :guest_team_id, :home_team_name, :guest_team_name, :guestboard_1, :guestboard_2,
                  :guestboard_3, :guestboard_4, :guestboard_5, :guestboard_6, :guestboard_7, :guestboard_8, :homeboard_1,
                  :homeboard_2, :homeboard_3, :homeboard_4, :homeboard_5, :homeboard_6, :homeboard_7, :homeboard_8,
                  :result, :result_1, :result_2, :result_3, :result_4, :result_5, :result_6, :result_7, :result_8,
                  :combat_day_id

  belongs_to :league

  belongs_to :combatday

  def self.find_open_combats
    Combat.joins(:combatday).where("(combats.result = '' or combats.result is null) and events.starttime < :start", {start: Time.now})
  end

end
