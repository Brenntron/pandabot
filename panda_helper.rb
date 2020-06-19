# frozen_string_literal: true

module PandaHelper
  @public_rooms = %w[Scene_Rm_1 Scene_Rm_2 Scene_Rm_3 hangout Monthly_Meetup]

  def self.get_chat_room(server)
    server.channels.find { |tc| tc.name == 'out-of-character-chat' || '25yrvtm-lounge' }
  end

  def self.bob_entered_public?(event, name)
    return false if event.channel.nil? || @public_rooms.include?(event.old_channel.name)

    user = event.user.on(event.server)

    user.username == name && @public_rooms.include?(event.channel.name)
  end

  def self.bob_left_public?(event, name)
    return false if event.old_channel.nil? || !@public_rooms.include?(event.old_channel.name)

    user = event.user.on(event.server)

    user.username == name
  end
end
