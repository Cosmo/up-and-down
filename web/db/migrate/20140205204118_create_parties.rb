class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :vanity

      t.timestamps
    end
  end
end
