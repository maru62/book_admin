class Author < ApplicationRecord

    # Authorとの多対多関連を中間テーブルを介して設定する
    has_many :book_authors
    has_many :books, through: :book_authors

end
