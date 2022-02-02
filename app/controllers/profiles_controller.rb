class ProfilesController < ApplicationController
    include HomeHelper
    include ProfilesHelper

    before_action :logged_in_user, only: [:update]
    before_action :correct_user,   only: [:update]

    def create
        # puts profile_params
        @profile = Profile.new(profile_params)
        if @profile.save
            flash[:success] = "Profile saved successfully."
            redirect_to edit_url
        else
            render 'new'
        end
    end

    def update
        updated_profile_params = update_array_attributes_in_params(profile_params)
        if params[:profile][:experiences_attributes]
            experience_params= params[:profile][:experiences_attributes].values
            # Updating experiences and projects
            experience_params.each do | ep |
                ep.delete('_destroy')
                @experience = Experience.find(ep[:id])
                if @experience.update(ep)
                    redirect_to edit_url and return
                else
                    render plain: "Not added Experience"
                end
            end
        end 
        
        if params[:profile][:educations_attributes]
            education_params= params[:profile][:educations_attributes].values
            # Updating Education
            education_params.each do | edp |
                edp.delete("_destroy")
                @education= Education.find(edp[:id])
                if @education.update(edp)
                    redirect_to edit_url and return
                else
                    render plain: "Not added Education"
                end
            end
        end
        
        
        # Updating Profile
        @profile = Profile.find(params[:id])
        if @profile.update(updated_profile_params)
            flash[:success] = "Profile updated successfully."
            redirect_to edit_url
        else
            flash[:danger] = "Profile update failed."
            redirect_to root_url
        end
    end

    def correct_user
        @profile = Profile.find(params[:id])
        @user = User.find(@profile.user_id)
        redirect_to(root_url) unless @user == current_user
    end

    def show
        if Profile.where(id: params[:id]).empty? 
            flash[:danger] = "Profile does not exist."
            if logged_in?
                redirect_to root_url
            else
                redirect_to(login_url)
            end
        else
            @profile = Profile.find(params[:id])
            if @profile.name.nil?
                @user = User.find(@profile.user_id)
                @profile.name = @user.name
            end
        
            render :template => "shared/profile/profile_preview" , locals: { profile: @profile}
        end
    end

    def preview
        if current_user.profile.name.nil?
            @user = User.find(current_user.profile.user_id)
            current_user.profile.name = @user.name
        end
        render :template => "shared/profile/profile_preview" , locals: { profile: current_user.profile}
    end

    private
        def profile_params
            params.require(:profile).permit(:name, :job_title, :total_experience, :overview, 
                :career_highlights, :primary_skills, :secondary_skills,
                :educations_attributes => [ :id, :school, :degree, :description, :start, :end, :_destroy],
                :experiences_attributes => [:id, :company, :position, :startdate, :enddate, :description, :_destroy],
                :projects_attributes => [:id, :title, :url, :tech_stack, :description, :_destroy])
        end
end 
