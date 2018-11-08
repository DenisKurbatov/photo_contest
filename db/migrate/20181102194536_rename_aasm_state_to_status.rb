class RenameAasmStateToStatus < ActiveRecord::Migration[5.2]
  def change
    rename_column :photos, :aasm_state, :status
  end
end
