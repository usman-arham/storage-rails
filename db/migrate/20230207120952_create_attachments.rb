class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table(:attachments, id: :string) do |t|
      t.text :data , null: false  
      t.timestamps
    end
  end
end
