class LoginsController < ApplicationController
    # 今のところ全く使わないコントローラー
    # ログインをするための画面そのものにログインは必要ないのでrequire_loginを飛ばす
    skip_before_action :require_login, only: [:new, :create]

    # 今動くサンプルではないようなのでいったん消しておく
=begin    
    # ここでいいんだろうか
    class LoginFailed < StandardError
    end

    def create
        @user = User.where(name: params[:name], password: params[:password]).find
        raise LoginFailed unless @user
    end
=end
    
end
