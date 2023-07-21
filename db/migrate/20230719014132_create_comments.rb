class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text     :content, null: false
      t.references :prototype, null: false
      t.references :user, null: false

      t.timestamps
    end
    #外部キーを追加
    add_foreign_key :comments, :prototypes
    add_foreign_key :comments, :users
  end
end
