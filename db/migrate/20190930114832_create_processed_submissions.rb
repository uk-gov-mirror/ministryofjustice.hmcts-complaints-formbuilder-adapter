class CreateProcessedSubmissions < ActiveRecord::Migration[6.0]
  def up
    create_table :processed_submissions, &:timestamps
  end
end
