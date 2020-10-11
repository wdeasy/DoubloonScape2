module Bot
  def self.get_role
    role = nil
    begin
      role = $bot.server(Settings.server).roles.find { |r| r.id == Settings.role }
    rescue Exception => msg
      Bot.log "Error while searching for the Captain Role object."
      puts msg
    end
    return role
  end

  def self.clear_roles
    role = get_role
    $bot.server(Settings.server).users.each do |user|
      user.roles.each do |r|
        if r.id.to_i == Settings.role
          revoke_role(user, role)
        end
      end
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
end
