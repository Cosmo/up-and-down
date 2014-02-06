class CreateMoviesParties < ActiveRecord::Migration
  def change
    create_table :movies_parties do |t|
      t.references :movie, index: true
      t.references :party, index: true
    end
  end
end
