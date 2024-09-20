class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats, comment: '对话' do |t|
      t.belongs_to :user, comment: '用户'
      t.string :name, comment: '名称'
      t.string :model, comment: '模型'

      t.timestamps
    end
  end
end
