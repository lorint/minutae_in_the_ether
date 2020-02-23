class CreateAetherFears < ActiveRecord::Migration[5.2]
  def change
    create_table :aether_fears do |t|
      t.string :name
      t.references :author, index: true

      t.datetime :created_at
    end

    create_table :aether_user_fears do |t|
      t.references :user, index: true
      t.references :fear, index: true
      t.integer :priority

      t.timestamps
    end
  end
end
