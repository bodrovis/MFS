class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :type
      t.integer :review_id
      t.integer :user_id

      t.timestamps
    end
  end
end
