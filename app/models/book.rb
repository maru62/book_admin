class Book < ApplicationRecord

    scope :costly, -> { where("price > ?", 3000) }

    scope :written_about, -> (theme) { where("name like ?", "%#{theme}%") }

    # 該当例がない場合条件を除外して全部返ってくる(!!??)
    #scope :find_price, ->(price) { find_by(price: price) }

    ## scopeの既定値を指定してしまうが強いのであまり使わない    
#   default_scope -> { order("published_on desc") }

    # 書籍はどこか一つの出版社に所属する
    belongs_to :publisher

    # Authorとの多対多関連を中間テーブルを介して設定する
    has_many :book_authors
    has_many :authors, through: :book_authors

    # 然るべき値の範囲を指定しておく、バリデーションヘルパー
    validates :name, presence: true
    validates :name, length: { maximum: 25 }
    validates :price, numericality: { greater_than_or_equal_to: 0 }

end