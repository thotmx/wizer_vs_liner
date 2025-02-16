class CreateHumen < ActiveRecord::Migration[8.0]
  def change
    create_table :humans do |t|
      t.string :name
      t.string :dna

      t.timestamps
    end
  end
end
