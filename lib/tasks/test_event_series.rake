namespace :test do
  desc "Insert an event as serie into database"
  task :insert_event => :environment do
    params = {:title => "Serientest",
              :place => "Vereinsheim",
              :category => "training",
              :owner_id => 1,
              :starttime => Time.now.beginning_of_hour,
              :endtime => 1.hour.since(Time.now.beginning_of_hour),
              :period => 'Daily',
              :frequency => 1}
    puts "params: #{params}"

    ev = EventSeries.new(params)
    if !ev.save
      puts "Error occured while saving the event serie."
    end

  end
end
