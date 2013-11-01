# encoding:utf-8
class OrganizationPlayer < ActiveRecord::Base
  # set_primary_key :index
  attr_accessible :birth_year, :club, :club_id, :dewis_club_id, :dwz, :elo, :fide_title, :first_name, :last_name, :pkz,
                  :status, :gender

  has_many :team_players
  # has_many :teams, through: :team_players

  before_save :set_index_and_club_data


  def self.generate_from_dewis(csv)
    # 0: ID, 1:VKZ, 2:Mgl-Nr, 3:Status, 4:Spielername, 6:Geschlecht, 7:Spielberechtigung, 8:Geburtsjahr, 9:Letzte-Auswertung,
    # 10:DWZ, 11: Index, 12:FIDE-Elo, 13:FIDE-Titel, 14:FIDE-ID, 15:FIDE-Land
    result = ''
    data = csv.gsub(/"/, '').split(',')
    pkz = data[0]
    player = OrganizationPlayer.find_or_initialize_by_pkz pkz
    result += player.new_record? ? 'Neu     : ' : 'Geändert: '
    player.update_attributes dewis_club_id: data[1], status: data[3], last_name: data[4], first_name: data[5],
                             gender: data[6], birth_year: data[8].to_i, dwz: data[10].to_i, elo: data[12].to_i,
                             fide_title: data[13]
    result += data[4] + ', ' + data[5] + ' ( ' + player.id  + ')'

    result
  end

  private
  def set_index_and_club_data
    self.status = 'A' if self.status.blank?
    self.index = self.club_id.to_s + self.pkz.to_s + self.status
    club = Club.find_by_zps self.dewis_club_id
    self.club_id = club.id
    self.club = club.name
  end
end
