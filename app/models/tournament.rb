# encoding:utf-8
class Tournament < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions

  attr_accessible :modus, :rounds, :state, :title, :referee

  MODI = [['Vollrundensystem', 'RobinRound'], ['doppelrund. Vollsystem', 'DoubleRobinRound'], ['K.O. System', 'KoSystem'], ['Schweizer System', 'SwissSystem']]

  state_machine do
    state :in_preparation
    state :running
    state :finished
    state :archived

    event :run do
      transitions :to => :running, :from => [:in_preparation]
    end
    event :finish do
      transitions :to => :finished, :from => [:running]
    end
    event :archive do
      transitions :to => :archived, :from => [:running, :finished]
    end
  end

  def state_name
    case self.state
      when 'in_preparation'
        result = "In Vorbereitung"
      when 'running'
        result = "läuft"
      when 'finished'
        result = "Abgeschlossen"
      when 'archived'
        result = "archiviert"
    end
    result
  end

  def self.actives
    Tournament.where{state != 'archived'}
  end
  def self.archive
    Tournament.where{state == 'archived'}
  end
end
