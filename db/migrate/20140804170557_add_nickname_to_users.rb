class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :text, default: nil
  end
end
