class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :party
      t.string :text

      t.timestamps
    end
  end
end
