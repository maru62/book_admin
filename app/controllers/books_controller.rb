class BooksController < ApplicationController

    # delete/destroyフック検証用の設定
    protect_from_forgery except: [:destroy]

    # protect_from_forgeryを除外できるがあまり推奨されない
    # protect_from_forgery except: :update

    # 書籍のインスタンス（実際にテーブルを操作するのでインスタンスでもない、正直よくわからない）作成を共通化するためのbefore_action設定
    # フック
    before_action :set_book, only: [:show, :destroy]

    # 唐突に例だけ出てくるaroundフック
    around_action :action_logger, only: [:destroy]

    # ブロックを用いた書き方
    ## また既定の約語だらけだな
    ## 今のところ意味不明なので消してもいいのでは
=begin    
    before action do
        redirect_to access_denied_path if params[:token].blank?
                                                #↑どっから湧いてくんだよこれ
    end
=end

    def show
        respond_to do |format|
            format.html     #   略式記法
            format.json { render json: @book }
        end
    end

    # destroyメソッドを追加する
    def destroy
    #   @book = Book.find(params[:id])  共通行なのでポア
        @book.destroy
        respond_to do |format|
            format.html { redirect_to "/" }
            format.json { head :no_content }
        end
    end

    private

    def set_book
        @book = Book.find(params[:id])
    end

    # とってつけたような例
    ## Windows環境？でcurlが動かないので検証できない
    def action_logger
        logger.info "around-before"
        yield
        logger.info "around-after"
    end    

end
