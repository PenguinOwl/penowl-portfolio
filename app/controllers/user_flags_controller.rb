class UserFlagsController < ApplicationController
  before_action :authenticate_user!
  before_action do
    user_flag "admin"
  end
  before_action :set_user_flag, only: [:show, :edit, :update, :destroy]

  # GET /user_flags
  # GET /user_flags.json
  def index
    @user_flags = UserFlag.all
  end

  # GET /user_flags/1
  # GET /user_flags/1.json
  def show
  end

  # GET /user_flags/new
  def new
    @user_flag = UserFlag.new
  end

  # GET /user_flags/1/edit
  def edit
  end

  # POST /user_flags
  # POST /user_flags.json
  def create
    @user_flag = UserFlag.new(user_flag_params)

    respond_to do |format|
      if @user_flag.save
        format.html { redirect_to @user_flag, notice: 'User flag was successfully created.' }
        format.json { render :show, status: :created, location: @user_flag }
      else
        format.html { render :new }
        format.json { render json: @user_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_flags/1
  # PATCH/PUT /user_flags/1.json
  def update
    respond_to do |format|
      if @user_flag.update(user_flag_params)
        format.html { redirect_to @user_flag, notice: 'User flag was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_flag }
      else
        format.html { render :edit }
        format.json { render json: @user_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_flags/1
  # DELETE /user_flags/1.json
  def destroy
    @user_flag.destroy
    respond_to do |format|
      format.html { redirect_to user_flags_url, notice: 'User flag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_flag
      @user_flag = UserFlag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_flag_params
      params.require(:user_flag).permit(:user, :content)
    end
end
