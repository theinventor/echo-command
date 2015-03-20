# class AuthenticationsController < ApplicationController
#   before_action :set_authentication, only: [:show, :edit, :update, :destroy]
#
#   # GET /authentications
#   # GET /authentications.json
#   def index
#     @authentications = Authentication.all
#   end
#
#   # GET /authentications/1
#   # GET /authentications/1.json
#   def show
#   end
#
#   # GET /authentications/new
#   def new
#     @authentication = Authentication.new
#   end
#
#   # GET /authentications/1/edit
#   def edit
#   end
#
#   # POST /authentications
#   # POST /authentications.json
#   def create
#     @authentication = Authentication.new(authentication_params)
#
#     respond_to do |format|
#       if @authentication.save
#         format.html { redirect_to @authentication, notice: 'Authentication was successfully created.' }
#         format.json { render :show, status: :created, location: @authentication }
#       else
#         format.html { render :new }
#         format.json { render json: @authentication.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /authentications/1
#   # PATCH/PUT /authentications/1.json
#   def update
#     respond_to do |format|
#       if @authentication.update(authentication_params)
#         format.html { redirect_to @authentication, notice: 'Authentication was successfully updated.' }
#         format.json { render :show, status: :ok, location: @authentication }
#       else
#         format.html { render :edit }
#         format.json { render json: @authentication.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /authentications/1
#   # DELETE /authentications/1.json
#   def destroy
#     @authentication.destroy
#     respond_to do |format|
#       format.html { redirect_to authentications_url, notice: 'Authentication was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end
#
#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_authentication
#       @authentication = Authentication.find(params[:id])
#     end
#
#     # Never trust parameters from the scary internet, only allow the white list through.
#     def authentication_params
#       params.require(:authentication).permit(:uid, :nickname, :name)
#     end
# end
