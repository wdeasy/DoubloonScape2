module Bot
  def self.get_member(user_id)
    user = nil
    begin
      user = $bot.server(Settings.server).member(user_id)
    rescue Exception => msg
      Bot.log "Error while trying to get the member object."
      puts msg
    end
    return user
  end
end
