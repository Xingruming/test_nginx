class Message < ApplicationRecord
  belongs_to :chat

  ROLE_USER = "user"
  ROLE_ASSISTANT = "assistant"
  ROLE_SYSTEM = "system"
end
