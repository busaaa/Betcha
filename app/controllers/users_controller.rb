class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
     #  log_in @user
     #  wednesday_string = " and YEEY, it is #{view_context.link_to( "Wednesday", "http://isitwednesdaymydudes.ml")}, my dude!!!"
     #  flash[:success] = "Welcome #{@user.name}, start betching!" + (wednesday_string if Date.today.wday == 3).to_s
     #  redirect_to @user
    else
      render "new"
    end
  end

  def show
    @user_groups = User.find(params[:id]).groups
    @selected_user_groups = @user_groups.order(updated_at: :desc).limit(5)
  end

  def edit
    @user = User.find params[:id]
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:sucess] = "User with the name #{user.name} was deleted"
    redirect_to users_url
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find params[:id]
    # Miért nem működik az update_attributes, mert true-ra fut de a pl név változást vagy a password változást nem menti... a user_params-nak lesz egy :old_passwordje???
    if params[:user][:password].present? && @user.authenticate(params[:user][:old_password]) || params[:user][:password].empty? && @user.update(user_params)
   # if @user.update(user_params)
      flash[:success] = "Successfully updated Profile"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find params[:id]
      redirect_to root_url unless current_user? @user
    end

    def admin_user
      redirect_to(root_url) unless current_user.permission == "admin"
    end

end




