class AddStepLocationToSteps < ActiveRecord::Migration[5.0]
  def change
    add_column :steps, :step_location, :string
  end
end
