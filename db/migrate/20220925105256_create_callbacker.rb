class CreateCallbacker < ActiveRecord::Migration[7.0]
  def change
    create_table :callbackers do |t|
      t.string :title

      t.timestamps
    end
  end
end
