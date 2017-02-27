class CreateReflections < ActiveRecord::Migration[5.0]
  def change
    create_table :reflections do |t|
      t.integer :student_id
      t.integer :problem_id
      t.string :session_id
      t.boolean :reflection
      t.string :response_timing

      t.timestamps
    end
  end
end
