class DestroyUsersController < ApplicationController
  # GET /destroy_users
  # GET /destroy_users.json
  def index
    @destroy_users = DestroyUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @destroy_users }
    end
  end

  # GET /destroy_users/1
  # GET /destroy_users/1.json
  def show
    @destroy_user = DestroyUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @destroy_user }
    end
  end

  # GET /destroy_users/new
  # GET /destroy_users/new.json
  def new
    @destroy_user = DestroyUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @destroy_user }
    end
  end

  # GET /destroy_users/1/edit
  def edit
    @destroy_user = DestroyUser.find(params[:id])
  end

  # POST /destroy_users
  # POST /destroy_users.json
  def create
    @destroy_user = DestroyUser.new(params[:destroy_user])

    respond_to do |format|
      if @destroy_user.save
        format.html { redirect_to @destroy_user, notice: 'Destroy user was successfully created.' }
        format.json { render json: @destroy_user, status: :created, location: @destroy_user }
      else
        format.html { render action: "new" }
        format.json { render json: @destroy_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /destroy_users/1
  # PUT /destroy_users/1.json
  def update
    @destroy_user = DestroyUser.find(params[:id])

    respond_to do |format|
      if @destroy_user.update_attributes(params[:destroy_user])
        format.html { redirect_to @destroy_user, notice: 'Destroy user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @destroy_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destroy_users/1
  # DELETE /destroy_users/1.json
  def destroy
    @destroy_user = DestroyUser.find(params[:id])
    @destroy_user.destroy

    respond_to do |format|
      format.html { redirect_to destroy_users_url }
      format.json { head :no_content }
    end
  end
end
