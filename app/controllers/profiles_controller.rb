class ProfilesController < ApplicationController
  def show
  end

  def edit
  end

  def update
    user = current_user
    # params[:user] => {name: "todesking", email: "todesking@gyoepi.com"}
    # 現時点ではparamsを自由に受け入れてしまうので脆弱性がある、user=adminを入力されて設定値として入ってしまうなど
    user.update(params[:user])
  end

  private
  # 明示的に許可したキーのみを利用する
  def user_params
    params.require(:user).permit(:name, :email)
  end

=begin adminが実在する場合も考慮できる
  def user_params
    if current_user.admin?
      params.require(:user).permit(:name, :email, :admin)
    else
      params.require(:user).permit(:name, :email)
    end
  end
=end

# しかし動くものが全然出てこないね

end
