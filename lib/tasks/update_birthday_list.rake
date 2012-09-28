namespace :schachclub do
  desc "update calendar with the member's birthdays"
  task :update_birthdays_in_calendar => :environment do
    Event.where('category = ?', 'birthday').each{|e| e.destroy}
    for user in User.birthday_list do
      params = {:title => user.first_last_name,
                :category => "birthday",
                :owner_id => 1,
                :starttime => user.birth_date.to_datetime,
                :endtime => user.birth_date.to_datetime,
                :period => 'Yearly',
                :frequency => 1,
                :all_day => true}
      ev = EventSeries.new(params)
      if !ev.save
        puts "Error occured while saving #{user.first_last_name}'s birthday."
      end
    end

  end
end
