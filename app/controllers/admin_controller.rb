class AdminController < ApplicationController
  before_action :require_any_admin_permissions

  private

  def require_any_admin_permissions
    redirect_to root_path unless user_signed_in? &&
                                 (current_user.can?(:edit, :games) ||
                                  current_user.can?(:edit, :competitions))
  end
end
