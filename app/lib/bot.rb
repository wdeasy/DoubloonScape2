module Bot
  module DiscordEvents; end
  module DiscordCommands; end

  def Bot.start
    #create the bot
    $bot = Discordrb::Commands::CommandBot.new(client_id: Settings.client_id,
                                              token: Settings.token,
                                              prefix: Settings.prefix)#,
                                              #log_mode: :debug)

    #bot helpers
    Dir['app/lib/modules/*.rb'].each { |mod| load mod }


    #create queue
    $queue = Queue.new
    $cooldown = Time.now - Settings.cooldown

    #bot events
    Dir['app/lib/events/*.rb'].each { |mod| load mod }
    DiscordEvents.constants.each do |mod|
      $bot.include! DiscordEvents.const_get mod
    end

    #bot rate limiting
    $bot.bucket :limit, limit: 60, time_span: 60, delay: 1

    #run
    $bot.run
  end
end
