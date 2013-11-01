# encoding:utf-8
require 'nokogiri'

namespace :dewis do
  desc 'Updates all players of a club'
  task :update_club_players, [:zps] => [:environment] do |t, args|
    zps = args[:zps]
    puts "Read document from 'http://www.schachbund.de/verein.html?zps=#{zps}'"
    begin
      doc = Nokogiri::HTML(open("http://www.schachbund.de/verein.html?zps=#{zps}"))
    rescue Exception => exc
      puts 'Error occured while reading Page from Deutscher Schachbund'
      puts exc.message
      return false
    end

    table = doc.at_xpath '//*[@id="dewis"]/div/table/tbody'
    club = doc.at_xpath('//*[@id="dewis"]/div/h2').text[10..-1]

    # puts table.to_s

    idx = 0
    table.children.each do
      idx += 1
      pkz = table.at_xpath("//tr[#{idx}]/td[4]/a").attr('href').to_s[-8..-1].to_i
      status = table.at_xpath("//tr[#{idx}]/td[3]").text
      status = 'A' if status.blank?
      full_name = table.at_xpath("//tr[#{idx}]/td[4]/a").text.split(',')
      first_name = full_name[1]
      last_name = full_name[0]
      title = table.at_xpath("//tr[#{idx}]/td[9]").text
      gender = table.at_xpath("//tr[#{idx}]/td[5]").text
      gender = 'm' if gender.blank?
      dwz_array = table.at_xpath("//tr[#{idx}]/td[7]").text.split '-'
      if dwz_array[1].blank?
        dwz = 0
      else
        dwz = dwz_array[0].gsub(/\D/, '').to_i
      end
      elo = table.at_xpath("//tr[#{idx}]/td[8]").text.to_i
      club_id = table.at_xpath("//tr[#{idx}]/td[2]/a").attr('href').to_s[-10..-5].to_i

      index = club_id.to_s + pkz.to_s + status
      op = OrganizationPlayer.where(first_name: first_name, last_name: last_name, dewis_club_id: club_id).first
      op = OrganizationPlayer.new if op.blank?
      op.index = index
      op.pkz = pkz
      op.club = club
      op.dewis_club_id = club_id if op.new_record?
      op.status = status
      op.first_name = first_name if op.new_record?
      op.last_name = last_name if op.new_record?
      op.fide_title = title
      op.gender = gender
      op.dwz = dwz
      op.elo = elo

      if op.changed?
        puts "#{op.new_record? ? 'Neu      ' : 'Geändert '}: #{pkz} - #{title} #{first_name} #{last_name} - #{gender} - #{dwz} - #{elo} - #{club}, #{club_id}"
        op.save
      else
        puts "Identisch: #{pkz} - #{title} #{first_name} #{last_name} - #{gender} - #{dwz} - #{elo} - #{club}, #{club_id}"
      end
    end
  end

  desc 'Update all players from all clubs of a district'
  task :update_all_club_players, [:zps] => :environment do |t, args|
    zps = args[:zps]
    Club.where('zps LIKE ?', zps + '%').map{|c| c.zps}.each do |zps|
      Rake::Task['dewis:update_club_players'].reenable
      Rake::Task['dewis:update_club_players'].invoke(zps)
    end
  end

end
