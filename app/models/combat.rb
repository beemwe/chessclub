# encoding: utf-8
class Combat < ActiveRecord::Base
  attr_accessible :league_id, :home_team_id, :guest_team_id, :home_team_name, :guest_team_name, :guestboard_1, :guestboard_2,
                  :guestboard_3, :guestboard_4, :guestboard_5, :guestboard_6, :guestboard_7, :guestboard_8, :homeboard_1,
                  :homeboard_2, :homeboard_3, :homeboard_4, :homeboard_5, :homeboard_6, :homeboard_7, :homeboard_8,
                  :result, :result_1, :result_2, :result_3, :result_4, :result_5, :result_6, :result_7, :result_8,
                  :combat_day_id

  belongs_to :league

  belongs_to :combatday, foreign_key: :combat_day_id

  after_update :calculate_team_ranking

  def calculate_team_ranking
    teams = self.league.teams
    teams.each do |t|
      t.points = 0
      t.board_points = ''
      t.board_points_plus = 0
      t.board_points_minus = 0
    end
    combats = self.league.combats

    combats.each do |combat|
      unless combat.result.blank?
        result = combat.result.split ':'
        home_team_points = 0
        guest_team_points = 0
        home_board_points = result[0].gsub(/½/, '.5').to_f
        guest_board_points = result[1].gsub(/½/, '.5').to_f
        if (home_board_points > guest_board_points)
          if home_board_points > 3.5
            home_team_points = 3
          else
            home_team_points = 2
          end
          guest_team_points = 0
        elsif (home_board_points < guest_board_points)
          if guest_board_points > 3.5
            guest_team_points = 3
          else
            guest_team_points = 2
          end
          home_team_points = 0
        elsif (home_board_points == guest_board_points) && (home_board_points == 4)
          home_team_points = 1
          guest_team_points = 1
        end

        team = teams.find { |t| t.id == self.home_team_id }
        team.points = home_team_points
        team.board_points_plus = home_board_points
        team.board_points_minus = guest_board_points

        team = teams.find { |t| t.id == self.guest_team_id }
        team.points = guest_team_points
        team.board_points_plus = guest_board_points
        team.board_points_minus = home_board_points
      end
    end
  end
end
