# encoding:utf-8
class Combatday < Event
  belongs_to :team

  attr_accessor :combat_date
  #attr_accessor :home_game
  attr_accessible :combat_date, :home_game

  def combatand

  end

  def combat_date
    starttime
  end

  def combat_date=(value)
    time_value = Time.parse(value)
    self.starttime = time_value.beginning_of_day + 10.hours
    self.endtime = time_value.beginning_of_day + 16.hours
    self.category = 'battle'
  end

  def home_game
    if place.present?
      result = place == 'Vereinsheim, Auf der Lände 2, 82256 Fürstenfeldbruck'
      puts "Ort: #{place}"
    else
      result = false
    end
    result
  end

  def home_game=(value)
    if value == true || value == 1 || value == '1'
      self.place= 'Vereinsheim, Auf der Lände 2, 82256 Fürstenfeldbruck'
    else
      self.place= 'unbekannt'
    end
  end
end
