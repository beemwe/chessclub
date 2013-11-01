# encoding:utf-8
class Combatday < Event
  belongs_to :league
  has_many :combats

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
    logger.info "parsed Time: #{I18n.l(time_value, :format => :long)}"

    begin
      kick_off = self.league.kick_off.split(':')
      durance = self.league.durance
    rescue
      kick_off = %w(10, 0)
      durance = 6
    end



    self.starttime = time_value.beginning_of_day + kick_off[0].to_i.hours + kick_off[1].to_i.minutes
    self.endtime = self.starttime + durance.hours
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
