class CreateBlobs < ActiveRecord::Migration[7.0]
  def change
    create_table(:blobs, id: :string) do |t|
      t.integer :size, null: false 
      t.timestamps
    end
  end
end
