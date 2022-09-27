class CreateHasOne < ActiveRecord::Migration[7.0]
  def change
    create_table :has_ones do |t|

      t.timestamps
    end

    add_reference :callbackers, :has_one, index: true
  end
end
