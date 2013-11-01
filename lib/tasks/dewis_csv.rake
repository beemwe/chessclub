# encoding:utf-8
require 'nokogiri'
require 'csv'

namespace :dewis do
  desc 'Updates all Clubs of Deutscher Schachbund via CSV file'
  task :update_clubs, [:file_name] => [:environment] do |t, args|
    file_name = args[:file_name]
    puts "Lese Datei: #{file_name}"
    CSV.foreach(file_name, :headers => true) do |row|
      result = Club.generate_from_dewis row.to_s
      if result.class.to_s == 'Club'
        puts "#{result.name} updated."
      end
    end
  end

  desc 'Updates all Players of Deutscher Schachbund via CSV file'
  task :update_players, [:file_name] => [:environment] do |t, args|
    file_name = args[:file_name]
    puts "Lese Datei: #{file_name}"
    CSV.foreach(file_name, :headers => true) do |row|
      result = OrganizationPlayer.generate_from_dewis row.to_s
      puts result
    end
  end

end