# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

panda = Discordrb::Bot.new token: ENV['BOT_KEY'], client_id: ENV['CLIENT_ID']

panda.message(with_text: 'Bobahito is here!') do |event|
  event.respond 'https://media.giphy.com/media/tlLBddTfaJmJG/giphy.gif'
end

panda.voice_state_update do |event|
  head_st = 'Robert Batton'
  server = event.server
  out_of_character = server.channels.find { |tc| tc.name == 'out-of-character-chat' }

  if entered_public?(event, head_st)
    out_of_character.send_message "Bobahito in the hoooouse!\nhttps://media.giphy.com/media/tlLBddTfaJmJG/giphy.gif"
  end
end

def entered_public?(event, name)
  public_rooms = %w[Hangout Scene_Rm_1 Scene_Rm_2 Scene_Rm_3]

  return false if event.channel.nil?

  if event.old_channel
    return false if public_rooms.include?(event.old_channel.name)
  end

  user = event.user.on(event.server)

  user.username == name && public_rooms.include?(event.channel.name)
end

panda.run
