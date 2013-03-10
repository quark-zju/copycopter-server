class ProjectsController < ApplicationController
  before_filter :authorize, :only => [:show]

  def index
    @projects = Project.active
  end

  def show
    @project = Project.find(params[:id])

    locale_id = params[:locale_id] || session[:locale_id]
    session[:locale_id] = locale_id
    @locale = @project.locale(locale_id)

    if stale? :etag => @project.etag
      @localizations = @project.localizations.in_locale_with_blurb(@locale)
    end
  end

end
