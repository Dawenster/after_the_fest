class AddBlockedImagesToKeyInputs < ActiveRecord::Migration
  def change
    add_attachment :key_inputs, :blocked_image
    add_attachment :key_inputs, :unavailable_image
  end
end
