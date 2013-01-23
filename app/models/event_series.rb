class EventSeries < ActiveRecord::Base
  attr_accessible :title, :description, :owner_id, :category, :place, :all_day, :starttime, :endtime, :frequency, :period

  attr_accessor :title, :description, :commit_button

  validates_presence_of :title, :period, :starttime, :endtime

  has_many :events, dependent: :destroy

  after_create :create_events_until


  def create_events_until(stop_time = END_TIME, repetitions = 0)
    st = starttime
    et = endtime
    counter = 0

    while st.to_f <= stop_time.to_f
      # generate the child event
      the_title =  category == "birthday" ? "#{title} (#{nst.year - starttime.year})" : title
      self.events.create(title: the_title, category: category, place: place, description: description,
                         all_day: all_day, starttime: st, endtime: et)
      counter += 1

      # calculate the next event's start and end time
      case period
        when 'Daily'
          st = 1.day.since(st)
          et = 1.day.since(et)
        when 'Weekly'
          st = 1.week.since(st)
          et = 1.week.since(et)
        when 'Weekly2'
          st = 2.week.since(st)
          et = 2.week.since(et)
        when 'Weekly3'
          st = 3.week.since(st)
          et = 3.week.since(et)
        when 'Weekly4'
          st = 4.week.since(st)
          et = 4.week.since(et)
        when 'Monthly'
          st = 1.month.since(st)
          et = 1.month.since(et)
        when 'Monthly2'
          st = 2.month.since(st)
          et = 2.month.since(et)
        when 'Monthly3'
          st = 3.month.since(st)
          et = 3.month.since(et)
        when 'Monthly6'
          st = 6.month.since(st)
          et = 6.month.since(et)
        when 'Yearly'
          st = 1.year.since(st)
          et = 1.year.since(et)
        when 'CountedWeekdayOfMonth'
          st = EventSeries.calculate_counted_weekday_of_month(st).to_time
          et = EventSeries.calculate_counted_weekday_of_month(et).to_time
        when 'LastWeekdayOfMonth'
          st = EventSeries.calculate_last_weekday_of_month(st).to_time
          et = EventSeries.calculate_last_weekday_of_month(et).to_time
      end
    end
  end

  def self.calculate_counted_weekday_of_month(in_date)
    date = in_date.to_datetime
    oneWeekBefore = 7.days.ago date
    twoWeeksBefore = 14.days.ago date
    threeWeeksBefore = 21.days.ago date
    fourWeeksBefore = 28.days.ago date

    if oneWeekBefore.month != date.month
      weekCounter = 1
    elsif twoWeeksBefore.month != date.month
      weekCounter = 2
    elsif threeWeeksBefore.month != date.month
      weekCounter = 3
    elsif fourWeeksBefore.month != date.month
      weekCounter = 4
    end

    next_first_of_month = 1.month.since(date.beginning_of_month).change hour: date.hour, min: date.min

    result = next_first_of_month
    counter = result.wday != date.wday ? 0 : 1
    while counter < weekCounter
      result = 1.day.since(result)
      counter += 1 if result.wday == date.wday
    end
    return result
  end

  def self.calculate_last_weekday_of_month(date)
    result = 1.month.since(date.end_of_month).change hour: date.hour, min: date.min
    # puts "#{result} - #{result.wday} : #{date.wday}"
    while date.wday != result.wday
      result = 1.day.ago result
    end
    return result
  end

end
