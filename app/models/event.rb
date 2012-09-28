class Event < ActiveRecord::Base
  attr_accessible :title, :place, :category, :description, :owner_id, :all_day, :endtime, :event_series_id, :starttime, :period, :frequency, :commit_button
  attr_accessor :period, :frequency, :commit_button

  validates_presence_of :title, :starttime, :endtime

  belongs_to :event_series

  REPEATS = [[I18n.t('period_options.no_repeat'), 'Does not repeat'],
             [I18n.t('period_options.daily'), 'Daily'],
             [I18n.t('period_options.weekly'), 'Weekly'],
             [I18n.t('period_options.weekly2'), 'Weekly2'],
             [I18n.t('period_options.weekly3'), 'Weekly3'],
             [I18n.t('period_options.weekly4'), 'Weekly4'],
             [I18n.t('period_options.firstweekdayofmonth'), 'FirstWeekdayOfMonth'],
             [I18n.t('period_options.secondweekdayofmonth'), 'SecondWeekdayOfMonth'],
             [I18n.t('period_options.thirdweekdayofmonth'), 'ThirdWeekdayOfMonth'],
             [I18n.t('period_options.fourthweekdayofmonth'), 'FourthWeekdayOfMonth'],
             [I18n.t('period_options.lastweekdayofmonth'), 'LastWeekdayOfMonth'],
             [I18n.t('period_options.monthly'), 'Monthly'],
             [I18n.t('period_options.monthly2'), 'Monthly3'],
             [I18n.t('period_options.monthly3'), 'Monthly3'],
             [I18n.t('period_options.monthly6'), 'Monthly6'],
             [I18n.t('period_options.yearly'), 'Yearly']]

  CATEGORIES = [['keine', 'none'],
                ['Training', 'training'],
                ['Mannschaftskampf', 'battle'],
                ['Turnier', 'tournament'],
                ['Geburtstag', 'birthday'],
                ['sonstige', 'other']]

  def validate
    if (starttime >= endtime) and !all_day
      errors.add_to_base(I18n.t('errors.messages.start_time_lt_end_time'))
    end
  end

  def update_events(events, event)
    events.each do |e|
      begin
        st, et = e.starttime, e.endtime
        e.attibutes = event
        if event_series.period.downcase == 'monthly' or event_series.period.downcase == 'yearly'
          nst = DateTime.parse("#{e.starttime.hour}:#{e.starttime.min}:#{e.starttime.sec}, #{e.starttime.day}-#{st.month}-#{st.year}")
          net = DateTime.parse("#{e.endtime.hour}:#{e.endtime.min}:#{e.endtime.sec}, #{e.endtime.day}-#{et.month}-#{et.year}")
        else
          nst = DateTime.parse("#{e.starttime.hour}:#{e.starttime.min}:#{e.starttime.sec}, #{st.day}-#{st.month}-#{st.year}")
          net = DateTime.parse("#{e.endtime.hour}:#{e.endtime.min}:#{e.endtime.sec}, #{et.day}-#{et.month}-#{et.year}")
        end
      rescue
        nst = net = nil
      end
      if nst and net
        e.starttime, e.endtime = nst, net
        e.save
      end
    end

    event_series.attributes = event
    event_series.save
  end

  def repeat_collection
    dow = self.starttime.wday
    Event::REPEATS.map {|p| [p[0].gsub(Regexp.new('%{day}'), I18n.t('date.day_names')[dow]), p[1]]}
  end
end
