class CreateEstimates < ActiveRecord::Migration[5.0]
  def change
    create_table :estimates do |t|
      t.integer :student_id
      t.integer :problem_id
      t.string :session_id
      t.integer :estimated_time
      t.string :response_timing

      t.timestamps
    end
  end
end
