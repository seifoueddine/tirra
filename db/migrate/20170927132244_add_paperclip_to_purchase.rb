class AddPaperclipToPurchase < ActiveRecord::Migration[5.1]
  def up
    add_attachment :purchases, :document
  end

  def down
    remove_attachment :purchases, :document
  end
end
