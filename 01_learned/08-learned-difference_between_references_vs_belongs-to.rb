# according to many stack overflow answers belongs_to and references are the same thing - https://stackoverflow.com/a/7795313 (it's also in the source code)
# references is an alias to belongs_to

# examples on how to read those

  # You could 'read' add_reference :products, :user, index: true - as - "products belong to user(s)" -- https://stackoverflow.com/a/62203069

  # You could 'read' the table books which references author - as - books belong to author(s)

# you will see both in your code when you use their respective keyword but they mean the same

  # example: author and book
    # An Author has many Books
    # A Book references an Author
    # A Book belongs to an Author.

  # these command tests were done with ruby 2.6.5 and rails 5.2

  # rails g model Book title year_published:integer author:references

        # db/migrate/20221111223126_create_books.rb
        class CreateBooks < ActiveRecord::Migration[5.2]
          def change
            create_table :books do |t|
              t.string :title
              t.integer :year_published
              t.references :author, foreign_key: true

              t.timestamps
            end
          end
        end

        # app/models/book.rb
        class Book < ApplicationRecord
          belongs_to :author
        end

        # db/schema.rb
        create_table "books", force: :cascade do |t|
          t.string "title"
          t.integer "year_published"
          t.integer "author_id"
          t.datetime "created_at", null: false
          t.datetime "updated_at", null: false
          t.index ["author_id"], name: "index_books_on_author_id"
        end
        add_foreign_key "books", "authors"


  # rails g model Book title year_published:integer author:belongs_to

        # db/migrate/20221111223126_create_books.rb
        class CreateBooks < ActiveRecord::Migration[5.2]
          def change
            create_table :books do |t|
              t.string :title
              t.integer :year_published
              t.belongs_to :author, foreign_key: true

              t.timestamps
            end
          end
        end

        # app/models/book.rb
        class Book < ApplicationRecord
          belongs_to :author
        end

        # db/schema.rb
        create_table "books", force: :cascade do |t|
          t.string "title"
          t.integer "year_published"
          t.integer "author_id"
          t.datetime "created_at", null: false
          t.datetime "updated_at", null: false
          t.index ["author_id"], name: "index_books_on_author_id"
        end
        add_foreign_key "books", "authors"


  # rails g model Book title year_published:integer author_id:integer:index -- https://stackoverflow.com/a/16309795

        # db/migrate/20221112152018_create_books.rb
        class CreateBooks < ActiveRecord::Migration[5.2]
          def change
            create_table :books do |t|
              t.string :title
              t.integer :year_published
              t.string :isbn
              t.decimal :price
              t.boolean :out_of_print
              t.integer :views
              t.integer :author_id # - does not sets the field as a foreign key, just creates the field and adds an index to it

              t.timestamps
            end
            add_index :books, :author_id
          end
        end

        # app/models/book.rb - there is no association on this one
        class Book < ApplicationRecord
        end

        # db/schema.rb
        create_table "books", force: :cascade do |t|
          t.string "title"
          t.integer "year_published"
          t.integer "author_id" # the integer created here ends as normal int instead of bigint (tested in postgres)
          t.datetime "created_at", null: false
          t.datetime "updated_at", null: false
          t.index ["author_id"], name: "index_books_on_author_id"
        end
        # no foreign key is added to the schema -- difference between foreign key and index: https://stackoverflow.com/a/1732508


  # rails g model Book title year_published:integer
  # rails g migration AddAuthorToBooks author:references
  #     - also tried AddAuthorsToBooks (authors in plural) and saw no change in databases, only in migration name

        # db/migrate/20221112195114_add_author_to_books.rb
        class CreateBooks < ActiveRecord::Migration[5.2]
          def change
            create_table :books do |t|
              t.string :title
              t.integer :year_published

              t.timestamps
            end
          end
        end

        # db/migrate/20221112195114_add_author_to_books.rb
        class AddAuthorToBooks < ActiveRecord::Migration[5.2]
          def change
            add_reference :books, :author, foreign_key: true
          end
        end

        # app/models/book.rb - migration alone adding references does not add an association to the model
        class Book < ApplicationRecord
        end

        # db/schema.rb
        create_table "books", force: :cascade do |t|
          t.string "title"
          t.integer "year_published"
          t.integer "author_id"
          t.datetime "created_at", null: false
          t.datetime "updated_at", null: false
          t.index ["author_id"], name: "index_books_on_author_id"
        end
        add_foreign_key "books", "authors"

        # conclusion: for separated migrations with references:
        #   two ways to do the same in terms of adding a reference between tables (index and foreign key)
            def change
              create_table :books do |t|
                # ...
                t.references :author, foreign_key: true
                # ...
              end
            end

            def change
              add_reference :books, :author, foreign_key: true
            end


  # rails g model Book title year_published:integer
  # rails g migration AddAuthorToBooks author:belongs_to
  #     conclusion: no noticeable difference between belongs_to and reference
  #     conclusion: when creating a migration alone, models will not be affected with the associations

        # db/migrate/20221114004623_create_books.rb
        class CreateBooks < ActiveRecord::Migration[5.2]
          def change
            create_table :books do |t|
              t.string :title
              t.integer :year_published

              t.timestamps
            end
          end
        end

        # db/migrate/20221114004627_add_author_to_books.rb
        class AddAuthorToBooks < ActiveRecord::Migration[5.2]
          def change
            add_reference :books, :author, foreign_key: true # rails prefers to use add_reference than add_belongs_to
          end
        end

        # app/models/book.rb
        class Book < ApplicationRecord
        end

        # db/schema.rb
        create_table "books", force: :cascade do |t|
          t.string "title"
          t.integer "year_published"
          t.integer "author_id"
          t.datetime "created_at", null: false
          t.datetime "updated_at", null: false
          t.index ["author_id"], name: "index_books_on_author_id"
        end
        add_foreign_key "books", "authors"


# can you replace the word belongs_to in models to references and it works?
  # test done
        class Book < ApplicationRecord
          references :author
          belongs_to :supplier
        end

        # then tried in rails console: Book.first.author
        # but got NoMethodError
        # conclusion: 'references' cannot replace 'belongs_to' in model associations, it seems that only in migrations

