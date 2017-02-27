class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :student_id
      t.integer :problem_id
      t.string :session_id
      t.string :answer
      t.string :response_timing

      t.timestamps
    end
  end
end
