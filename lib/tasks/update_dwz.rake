require 'nokogiri'

namespace :dewis do
  desc "update the DWZ to every Player in User-table"
  task :update_dwz => :environment do
    puts "Read document from 'http://www.schachbund.de/dwz/dewis/index.html?c=24404'"
    begin
      doc = Nokogiri::HTML(open('http://localhost:3000/DWZ-Abfrage.html'))
    rescue Exception => exc
      puts "Error occured while reading Page from Deutscher Schachbund"
      puts exc.message
      return ""
    end

    begin
      doc.css('div#country1 table.dwzliste tr').each do |line|
        name_node = line.at_xpath('.//td[@class="name"]')
        unless name_node.nil?
          dewis_id =  line.at_xpath('.//td[@class="name"]').children[0].attribute('name')
          dewis_name = line.at_xpath('.//td[@class="name"]').children[1].text
        end
        dwz_node = line.at_xpath('.//td[@class="dwz"]')
        unless dwz_node.nil?
          dewis_dwz_with_index = dwz_node.content
          unless dewis_dwz_with_index.blank?
            dewis_dwz = dewis_dwz_with_index.split('-')[0].slice(/\d{1,}/)
            dewis_index = dewis_dwz_with_index.split('-')[1].slice(/\d{1,}/)
          else
            dewis_dwz = "0"
            dewis_index = "0"
          end
        end
        user = User.find_by_dsb_id(dewis_id.to_s)
        user.update_attributes(:dwz => dewis_dwz) if user.present?
        puts "#{dewis_id}: #{user.present? ? '(updated!) ' : '' }#{dewis_name} - '#{dewis_dwz}' (index: '#{dewis_index}')" unless dwz_node.nil? || name_node.nil?
      end
    rescue Exception => exc
      puts "Error occured while interpreting tablerows"
      puts exc.message
    end

  end
end
