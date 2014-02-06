class CreateMoviesQuestions < ActiveRecord::Migration
  def change
    create_table :movies_questions do |t|
      t.references :movie, index: true
      t.references :question, index: true
    end
  end
end
