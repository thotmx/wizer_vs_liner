class AddHumanTypeToHumansTable < ActiveRecord::Migration[8.0]
  def change
    add_column :humans, :human_type, :string
  end
end
