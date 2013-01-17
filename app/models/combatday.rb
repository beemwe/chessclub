# encoding:utf-8
class Combatday < Event
  belongs_to :team

  attr_accessor :combat_date, :home_game
  attr_accessible :combat_date, :home_game

  def after_initialize
    self.category = 'battle'
    self.home_game= false
  end

  def combatand

  end

  def combat_date
    starttime
  end

  def combat_date=(value)
    time_value = Time.parse(value)
    self.starttime = time_value.beginning_of_day + 10.hours
    self.endtime = time_value.beginning_of_day + 16.hours
  end

  def home_game
    !self.place.nil? || self.place == 'Vereinsheim, Auf der Lände 2, 82256 Fürstenfeldbruck'
  end

  def home_game=(value)
    Rails.logger.info "Here I am"
    if value
      @place= 'Vereinsheim, Auf der Lände 2, 82256 Fürstenfeldbruck'
    else
      @place= 'unbekannt'
    end
  end
end
