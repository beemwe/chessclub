# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #  Include Paperclip
  include Paperclip::Glue

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessible :last_name, :first_name, :birth_date, :member_since, :dwz, :title, :dsb_id,
                  :avatar, :retained_avatar, :remove_avatar, :address, :zip, :location,
                  :phone, :mobile, :gender, :status
  attr_accessor :login
  attr_accessible :login

  has_many :blog_articles, :foreign_key => 'author_id'
  has_many :teams, :foreign_key => 'leader_id'

  has_and_belongs_to_many :roles

  validates_presence_of :last_name, :first_name, :username, :gender

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }

  before_save :set_roles

  def self.player
    User.where{(dsb_id != nil) & (dsb_id != '')}.order('dwz DESC')
  end

  def self.member
    User.where{member_since != nil}.order(:last_name, :first_name)
  end

  def self.squad(age = 0, girls_only = false)
    User.where{(dsb_id != nil) & (age = 0 | birth_date )}
  end

  def self.birthday_list
    User.where{birth_date != nil}
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def password_required?
    # !persisted? || !password.nil? || !password_confirmation.nil?
    false
  end

  def last_first_name
    "#{self.last_name}, #{self.first_name}"
  end

  def first_last_name
    "#{self.first_name} #{self.last_name}"
  end

  def get_dsb_player_data
    return "false" if self.dsb_id.blank?
    begin
      doc = Nokogiri::HTML(open("http://www.schachbund.de/dwz/db/spieler.html?zps=#{self.dsb_id}&template=/template/drucker.tpl"))
      doc.at_xpath("html//body//div//table")['width'] = '100%'
      doc.at_css(".baustelle")['style'] = 'display:none'
      result = doc.to_html.html_safe
    rescue Exception => exc
      result = "Fehler beim Zugriff auf den Server des Deutschen Schachbunds: <br>#{exc.message}".html_safe
    end

    result
  end

  def set_roles
    if self.member_since.present?
      self.roles << Role.find_by_name('Mitglied') unless self.role? :mitglied
    else
      self.roles.delete(Role.find_by_name('Mitglied')) if self.role? :mitglied
    end
    if self.dsb_id.present?
      self.roles << Role.find_by_name('Spieler') unless self.role? :spieler
    else
      self.roles.delete(Role.find_by_name('Spieler')) if self.role? :spieler
    end
  end

  def self.get_pagination_abrevs(per_page = 10)
    result = []
    users = User.order(:last_name, :first_name)
    max = users.count
    counter = (max % per_page) - 1
    counter.times do |cidx|
      p1 = users[cidx * per_page].last_name[0..2]
      p2idx = (cidx * per_page) + per_page - 1
      p2 = p2idx > max ? users.last.last_name[0..2] : users[p2idx].last_name[0..2]
      result.push "#{p1} - #{p2}"
    end
    result
  end

end
