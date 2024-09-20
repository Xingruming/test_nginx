class CreateDialogues < ActiveRecord::Migration[7.1]
  def change
    create_table :dialogues, comment: '对话记录' do |t|
      t.json :user_content, comment: '用户输入'
      t.text :assistant_content, size: :medium, comment: 'AI 回答'

      t.timestamps
    end
  end
end
