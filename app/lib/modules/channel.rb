module Bot
  def self.send_chat(message)
    begin
      $bot.channel(Settings.channel).send_message("`#{message}`")
    rescue Exception => msg
      Bot.log "Error while trying to send message to channel to:"
      Bot.log message
      puts msg
    end
  end
end
