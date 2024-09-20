class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, comment: '用户表' do |t|
      t.string :username, comment: '用户名'
      t.string :password_digest, comment: '密码'

      t.timestamps
    end
  end
end
