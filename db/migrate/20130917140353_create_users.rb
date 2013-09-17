class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :name
      t.string :nickname
      t.string :uid
      t.string :token
      t.string :secret
      t.string :profile_url
      t.string :image_url

      t.timestamps
    end
  end
end
