class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages

  MODELS = %w[skiff skiff_constraint]

  # {
  #   skiff: '无限制',
  #   skiff_constraint: '有限制'
  # }

  enum model: { skiff: 'skiff', skiff_constraint: 'skiff_constraint' }

  def history_messages
    messages.map do |message|
      [
        { role: Message::ROLE_USER, content: message.user_content },
        { role: Message::ROLE_ASSISTANT, content: message.assistant_content }
      ]
    end.flatten
  end
end
