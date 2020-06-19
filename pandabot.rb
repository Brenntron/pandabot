# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'
require './panda_helper'

panda = Discordrb::Bot.new token: ENV['BOT_KEY'], client_id: ENV['CLIENT_ID']

panda.message(with_text: 'Bobahito is here!') do |event|
  event.respond 'https://media.giphy.com/media/tlLBddTfaJmJG/giphy.gif'
end

panda.voice_state_update do |event|
  head_st = 'Brenntron'
  server = event.server
  chat_room = PandaHelper.get_chat_room(server)

  if PandaHelper.bob_entered_public?(event, head_st)
    chat_room.send_message "Bobahito in the hoooouse!\nhttps://media.giphy.com/media/tlLBddTfaJmJG/giphy.gif"
  end

  chat_room.send_message 'https://tenor.com/TGwe.gif' if PandaHelper.bob_left_public?(event, head_st)
end

panda.run
