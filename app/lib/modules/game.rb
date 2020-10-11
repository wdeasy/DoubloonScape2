module Bot
  def self.is_legit(event)
    legit = false
    return legit if event.message.channel.pm?
    return legit if event.author.bot_account?

    if event.channel.id.to_i == Settings.channel
      legit = true
    end

    return legit
  end

  def self.update_roles(user)
      $cooldown = Time.now + Settings.cooldown
      role = Bot.get_role
      clear_roles
      grant_role(user, role)
  end

  def self.grant_role(member, role)
    begin
      member.add_role role
    rescue Exception => msg
      Bot.log "Error granting Captain Role to the new captain."
      puts msg
    end
  end

  def self.revoke_role(member, role)
    begin
      member.remove_role role
    rescue Exception => msg
      Bot.log "Error revoking the Captain role."
      puts msg
    end
  end

  def self.log(message)
    puts "[#{Time.now.strftime("%d/%m/%y %H:%M:%S")}] -- #{message}"
  end
end
