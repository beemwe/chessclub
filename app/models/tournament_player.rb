class TournamentPlayer < ActiveRecord::Base
  attr_accessible :dwz, :first_name, :last_name, :fide_title

  belongs_to :tournament

  # validates_presence_of :last_name, :first_name

  serialize :result, Hash

  before_create :make_result_hash

  def add_game_result(combatant, value)
    old_value = self.result[combatant] || 0
    self.result[combatant] = value
    self.result[:points] += value - old_value
    save
  end

private

  def make_result_hash
    self.result = {points: 0, place: ''}
  end
end
