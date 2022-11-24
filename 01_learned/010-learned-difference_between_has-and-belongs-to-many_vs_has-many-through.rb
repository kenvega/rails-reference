# what happens if you create a model with HABTM associations and then you remove the model file and change and run the migration file
# is the resulting table from that migration different from creating a migration that creates only the join table?

# tests

  # test1 - create a model, and run the migrations
  # rails g model BookOrder book:belongs_to order:belongs_to

          # db/migrate/20221118121509_create_book_orders.rb
          class CreateBookOrders < ActiveRecord::Migration[5.2]
            # notices the name is incorrect because the table should be named books_orders (book is in singular in this test)
            def change
              create_table :book_orders do |t|
                t.belongs_to :book, foreign_key: true
                t.belongs_to :order, foreign_key: true
              end
            end
          end


  # test2 - use the generator for join tables
  # source: https://guides.rubyonrails.org/active_record_migrations.html#writing-a-migration:~:text=will%20produce%20join%20tables
  # rails generate migration CreateJoinTableBookOrder book order

          # db/migrate/20221119165315_create_join_table_book_order.rb
          class CreateJoinTableBookOrder < ActiveRecord::Migration[5.2]
            # there are indexes commented when the migration was created
            def change
              create_join_table :books, :orders do |t|
                # t.index [:book_id, :order_id]
                # t.index [:order_id, :book_id]
              end
            end
          end

  # test3 - create the migration manually and guide yourself with

  # another example (?) remove if no t needed
  #  rails generate migration CreateJoinTableCustomerProduct customer product