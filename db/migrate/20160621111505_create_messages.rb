class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :question, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :content

      t.timestamps null: false
    end
  end
end
