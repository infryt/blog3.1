class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :titulo
      t.text :body
      t.string :extension
      t.integer :user_id

      t.timestamps
    end
  end
end
