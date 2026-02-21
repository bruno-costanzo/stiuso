# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy deactivate]

  # GET /profile
  def show; end

  # GET /profile/new
  def new
    @profile = current_user.build_profile
  end

  # GET /profile/edit
  def edit; end

  # POST /profile
  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to profile_path, notice: "Profile was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /profile
  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Profile was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /profile
  def destroy
    @profile.destroy!
    redirect_to root_path, notice: "Profile was successfully destroyed.", status: :see_other
  end

  # POST /profile/deactivate
  def deactivate
    @profile.update!(active: false)
    redirect_to profile_path, notice: "Profile was deactivated.", status: :see_other
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.expect(profile: %i[name bio active])
  end

  def current_user
    Current.user
  end
end
