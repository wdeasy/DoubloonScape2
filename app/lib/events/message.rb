module Bot
  module DiscordEvents
    module Message
      extend Discordrb::EventContainer
      phrase = /\b[Ii]'?[Mm][ \t]+[Tt][Hh][Ee][ \t]+[Cc][Aa][Pp][Tt][Aa][Ii][Nn][ \t]+[Nn][Oo][Ww].?\b/
      message(contains: phrase) do |event|
        unless Bot.is_legit(event) == false
          if Time.now < $cooldown
            seconds = ($cooldown - Time.now).ceil
            Bot.send_chat("The Captain cannot be taken for #{seconds} more seconds.")
          else
            $queue.push(Bot.update_roles(event.author))
          end
        end
      end
    end
  end
end
