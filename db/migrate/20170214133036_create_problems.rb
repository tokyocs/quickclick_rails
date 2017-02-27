class CreateProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :problems do |t|
      t.text :problem
      t.string :image_url
      t.string :answer
      t.string :dummy1
      t.string :dummy2
      t.string :dummy3

      t.timestamps
    end
  end
end
