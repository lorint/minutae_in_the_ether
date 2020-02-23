class CreateAetherPowerful < ActiveRecord::Migration[5.2]
  def change
    create_table :aether_powerfuls do |t|
      t.string :name
      t.references :author, index: true

      t.datetime :created_at
    end

    create_table :aether_user_powerfuls do |t|
      t.references :user, index: true
      t.references :powerful, index: true
      t.integer :priority

      t.timestamps
    end


    create_table :aether_not_afraids do |t|
      t.string :name
      t.references :author, index: true

      t.datetime :created_at
    end

    create_table :aether_user_not_afraids do |t|
      t.references :user, index: true
      t.references :not_afraid, index: true
      t.integer :priority

      t.timestamps
    end
  end
end
