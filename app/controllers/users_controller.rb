class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if User.find_by_email(@user.email)
        format.html { redirect_to @user, notice: 'Email already in use.' }
        format.json { render json: {status: 400, error: "Email already in use."}}
      elsif User.find_by_mobile(@user.mobile)
        format.html { redirect_to @user, notice: 'Moblie already in use.' }
        format.json { render json: {status: 400, error: "Moblie already in use."}}
      elsif @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def signin
    @user=User.where(:email => params[:email]).first
    respond_to do |format|
      if @user.present? && @user.password == params[:password]
        format.html { redirect_to @user, notice: 'Signin sccessfull.' } 
        format.json { render json: {status: 200 ,user: @user}}
      else
        format.html { render :show, notice: 'Login failed.' } 
        format.json { render json: {status: 404 ,error: "No user found with this email."}}
      end
    end
  end
  
  def forgot
    @user=User.where(:email => params[:email]).first
    respond_to do |format|
      if @user.present?
        format.json { render json: {status: 200 ,password: @user.password}}
      else
        format.json { render json: {status: 404 ,error: "No user found with this email."}}
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :mobile, :password)
    end
end
