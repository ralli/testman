class CreateTestcaseAttachments < ActiveRecord::Migration
  def self.up
    create_table :testcase_attachments do |t|
      t.integer :testcase_id
      t.integer :position
      t.text :description

      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
    end

    add_index(:testcase_attachments, [:testcase_id, :position])
  end

  def self.down
    drop_table :testcase_attachments
  end
end
