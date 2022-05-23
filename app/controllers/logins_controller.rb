class LoginsController < ApplicationController
    # 今のところ全く使わないコントローラー
    # ログインをするための画面そのものにログインは必要ないのでrequire_loginを飛ばす
    skip_before_action :require_login, only: [:new, :create]
end
