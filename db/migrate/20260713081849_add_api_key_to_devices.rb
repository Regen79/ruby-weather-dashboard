class AddApiKeyToDevices < ActiveRecord::Migration[8.1]
  def change
    add_column :devices, :api_key, :string
    add_index :devices, :api_key, unique: true
  end
end