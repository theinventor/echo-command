class LightSwitchesController < ApplicationController
  before_action :set_light_switch, only: [:update, :destroy]

  def show
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Switch was successfully updated.' }
      format.json { render json: {} }
      format.js { render json: {} }
    end
  end

  # PATCH/PUT /authentications/1
  # PATCH/PUT /authentications/1.json
  def update
    respond_to do |format|
      if @light_switch.update(light_switch_params)
        format.html { redirect_to @light_switch, notice: 'Switch was successfully updated.' }
        format.json { respond_with_bip(@light_switch)}
      else
        format.html { render :edit }
        format.json { respond_with_bip(@light_switch) }
      end
    end
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @light_switch.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Switch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_light_switch
    @light_switch = LightSwitch.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def light_switch_params
    params.require(:light_switch).permit(:turn_on, :turn_off)
  end
end
