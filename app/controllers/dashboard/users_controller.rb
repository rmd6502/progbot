
class Dashboard::UsersController < Dashboard::BaseController
  inherit_resources
  defaults :singleton => true
  
  def edit
    current_user.valid?
  end

  def update
    if current_user.update(user_params)
      redirect_to dashboard_root_path
    else
      render :edit
    end
  end

  protected
    def resource
      current_user
    end

  private

    def user_params
      params.require(:user).permit(
        :edit, :anonymous, :join_reason,
        :overview, :location, :tech_skill_names, :non_tech_skill_names,
        :optin, :phone, :read_code_of_conduct,
        :verification_urls, :hear_about_us, :is_approved, :gender_pronouns, :additional_info
      )
    end
end
