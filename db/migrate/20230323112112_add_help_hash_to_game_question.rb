class AddHelpHashToGameQuestion < ActiveRecord::Migration
  def change
    # Полем text будем пользоваться как хеш-массивом
    add_column :game_questions, :help_hash, :text
  end
end
