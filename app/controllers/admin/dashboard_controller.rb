class Admin::DashboardController < Admin::AdminController
  before_action :set_account

  def index
    @users = @account.users
  end

  private

  def set_account
    @account = current_user.account
  end
end
