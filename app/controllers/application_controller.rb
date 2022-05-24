class ApplicationController < ActionController::Base
    # 親クラスで設定したフックを子クラスで飛ばしたいとき
    # ログインが必要なアプリなど
    before_action :require_login

    # ログイン失敗時
    rescue_from LoginFailed, with: :login_failed

    def require_login
        # ログインを確認して非ログイン時にリダイレクトするなど
    end

    def login_failed
        render template: "shared/login_failed", status: 401
    end

end
