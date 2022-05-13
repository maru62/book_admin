class Book < ApplicationRecord

    # 販売状況のフラグを列挙しておく
    enum sales_status: {
        accepting_reservation:  0,
        now_on_sale:            1,
        end_of_pring:           2,
    }

    # 高額な本を指定したスコープ
    scope :costly, -> { where("price > ?", 3000) }
    # 題名をlikeで絞り込むスコープ
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

    # validateブロックで複雑なバリデーションをする
    validate do |book|
        if book.name.include?("exercise")
            book.errors[:name] << "I don't like exercise."
        end
    end

    # before_validationブロックでコールバックを追加できる
    before_validation do
        self.name = self.name.gsub(/Cat/) do |matched|
            "lovely #{matched}"
        end
    end

=begin 上と重複
    # 引数なしメソッド（クラスメソッド（だっけ？）っていう名前が覚えられないのでプロシージャとかにしてほしい）
    def add_lovely_to_cat
        self.name = self.name.gsub(/Cat/) do |matched|
            "lovely #{matched}"
        end
    end
=end

=begin
    # 削除された後にフックするためのメソッドがいちいちある、覚えてらんない
    ## うまく動かない
    after_destroy do
        Rails.logger.info "Book is deleted: #{self.attributes}"
                                                    #↑何これ
    end
=end
    
    # 高価な本を削除するときに警告する
    ## 動いた、上どこ間違えてるんだろ
    after_destroy :if => :high_price? do
        Rails.logger.warn "You deleted an expensive book: #{self.attributes}"
        Rails.logger.warn "You need to review this operation."
    end

    def high_price? 
        price >= 5000
    end

end