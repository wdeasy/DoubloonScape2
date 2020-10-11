namespace :bot do
  task :run => :environment do
    Bot.start
  end
end
