class CreateHasMany < ActiveRecord::Migration[7.0]
  def change
    create_table :has_manies do |t|

      t.timestamps
    end

    add_reference :callbackers, :has_many, index: true
  end
end
