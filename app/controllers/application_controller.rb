class ApplicationController < ActionController::Base
    # 親クラスで設定したフックを子クラスで飛ばしたいとき
    # ログインが必要なアプリなど
    before_action :require_login

    def require_login
        # ログインを確認して非ログイン時にリダイレクトするなど
    end

end
