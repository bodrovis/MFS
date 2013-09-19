class RenameTypeInVotes < ActiveRecord::Migration
  def up
    remove_column :votes, :type
    add_column :votes, :vote_type, :string
  end

  def down

  end
end
