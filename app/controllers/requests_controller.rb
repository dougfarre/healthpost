class RequestsController < ApplicationController
  
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
    ts = current_user.roles.map {|x| x.name}.include?("transfer_center")
    if ts 
      #@requests = Request.where(:transfer_center_id => current_user.transfer_center_id)
      respond_to do |format|
        format.html { render  action: 'ts_index' } 
        format.json { render json: @requests }
      end
    else
      #@requests = Request.where(:practice_id => current_user.practice.id)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @requests }
      end
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])
    @availabilities = HospitalBedAvailability.prepare_nested_form(@request)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = current_user.practice.requests.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = current_user.practice.requests.build
    @request.assign_attributes(params[:request])
    @request.user_created_by = current_user
    
    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])
    @request.user_updated_by = current_user
    @request.transition = params[:transition] unless params[:transition].blank?

    respond_to do |format|
      if @request.update_attributes(params[:request]) 
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.js   { render json: @request.errors, status: :unprocessable_entit}
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end
end
