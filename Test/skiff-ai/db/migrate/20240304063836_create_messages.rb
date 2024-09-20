class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages, comment: '消息' do |t|
      t.belongs_to :chat
      t.text :user_content, comment: '用户输入'
      t.text :assistant_content, comment: '模型回答'

      t.timestamps
    end
  end
end
