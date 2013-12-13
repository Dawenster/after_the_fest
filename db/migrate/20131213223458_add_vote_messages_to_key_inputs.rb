class AddVoteMessagesToKeyInputs < ActiveRecord::Migration
  def change
    add_column :key_inputs, :up_vote_message, :string
    add_column :key_inputs, :down_vote_message, :string
  end
end
