require "nokogiri"
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  # projects: kickstarter.css('li.project.grid_4')
  # title: project.css('h2.bbcard_name strong a')
  # image link: project.css('.project-thumbnail a img').attribute('src').value
  #description: project.css('p.bbcard_blurb').text.strip
  #location: project.css('ul.project-meta span.location-name').text
  #percent_funded: project.css('ul.project-stats li.first.funded strong').text.gsub('%',"").to_i

  projects = kickstarter.css('li.project.grid_4')

  project_hash = {}

  projects.each do |project|
    project_hash[project.css('h2.bbcard_name strong a').text] = {}
  end

  project_hash.each do |key, value|
    value[:image_link] = projects.css('.project-thumbnail a img').attribute('src').value
    value[:description] = projects.css('p.bbcard_blurb').text.strip
    value[:location] = projects.css('p.bbcard_blurb').text.strip
    value[:percent_funded] = projects.css('ul.project-stats li.first.funded strong').text.gsub('%',"").to_i
  end

  project_hash
  binding.pry
end

create_project_hash
