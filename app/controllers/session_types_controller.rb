class SessionTypesController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :assign_current_event_or_redirect
  before_filter :normalize_event_path_or_redirect, :only => [:index]
  before_filter :add_event_breadcrumb
  before_filter :add_session_types_breadcrumb
  before_filter :assign_session_type, :only => [:show, :edit, :update, :destroy]
  
  # GET /session_types
  # GET /session_types.xml
  def index
    @session_types = @event.session_types

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @session_types }
    end
  end

  # GET /session_types/1
  # GET /session_types/1.xml
  def show
    add_breadcrumb @session_type.title

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @session_type }
    end
  end

  # GET /session_types/new
  # GET /session_types/new.xml
  def new
    @session_type = SessionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session_type }
    end
  end

  # GET /session_types/1/edit
  def edit
  end

  # POST /session_types
  # POST /session_types.xml
  def create
    @session_type = SessionType.new(params[:session_type])
    @session_type.event = @event

    respond_to do |format|
      if @session_type.save
        flash[:notice] = 'SessionType was successfully created.'
        format.html { redirect_to(session_types_path) }
        format.xml  { render :xml => @session_type, :status => :created, :location => @session_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @session_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /session_types/1
  # PUT /session_types/1.xml
  def update
    respond_to do |format|
      if @session_type.update_attributes(params[:session_type])
        flash[:notice] = 'SessionType was successfully updated.'
        format.html { redirect_to(@session_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @session_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /session_types/1
  # DELETE /session_types/1.xml
  def destroy
    @session_type.destroy

    respond_to do |format|
      format.html { redirect_to(session_types_url) }
      format.xml  { head :ok }
    end
  end
  
  protected

    def add_event_breadcrumb
      add_breadcrumb @event.title, @event
    end

    def add_session_types_breadcrumb
      add_breadcrumb "Session Types", session_types_path
    end

    def assign_session_type
      begin
        @session_type = SessionType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:failure] = "Sorry, that session type doesn't exist or has been deleted."
        return redirect_to(:action => :index)
      end
    end

end
