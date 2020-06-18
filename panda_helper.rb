# frozen_string_literal: true

module PandaHelper
  attr_reader :community_public_rooms, :curse_of_caine_public_rooms

  @community_public_rooms = %w[Scene_Rm_1 Scene_Rm_2 Scene_Rm_3]
  @curse_of_caine_public_rooms = %w[hangout Monthly_Meetup]

  def self.get_chat_room(server)
    server.channels.find { |tc| tc.name == 'out-of-character-chat' || '25yrvtm-lounge' }
  end

  def self.entered_public?(event, name)
    return false if event.channel.nil?

    if event.old_channel
      return false if from_public_room?(event.old_channel.name)
    end

    user = event.user.on(event.server)

    user.username == name && public_rooms.include?(event.channel.name)
  end

  private

  def from_public_room?(room_name)
    curse_of_caine_public_rooms.include?(room_name) || community_public_rooms.include?(room_name)
  end
end
