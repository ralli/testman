class CreateTeststeps < ActiveRecord::Migration
  def self.up
    create_table :teststeps do |t|
      t.integer :testcase_id
      t.integer :position
      t.text :step
      t.text :expected_result

      t.timestamps
    end

    add_index(:teststeps, [:testcase_id, :position])
  end

  def self.down
    drop_table :teststeps
  end
end
