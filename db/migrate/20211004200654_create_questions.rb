class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :user_email, null: false, index: true
      t.string :user_name, null: false
      t.string :question, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
