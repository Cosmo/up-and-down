class RemovePartyIdFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :party_id, :integer
  end
end
