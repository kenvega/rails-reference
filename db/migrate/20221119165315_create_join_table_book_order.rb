class CreateJoinTableBookOrder < ActiveRecord::Migration[5.2]
  # TODO: current example of what is created with a generator for a joining table... probably will remove this migration to try others
  def change
    create_join_table :books, :orders do |t|
      # t.index [:book_id, :order_id]
      # t.index [:order_id, :book_id]
    end
  end
end
