class SettingsController < ApplicationController

  def new
    @setting = Setting.new
  end
  
  def edit
    @setting = Setting.find(params[:id])
    authorize @setting
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update(setting_params)
    authorize @setting
    @setting.save
    redirect_to pharmacy_stock_items_compare_path
  end

  def setting_params
    params.require(:setting).permit(:name, :percent_difference)
  end
end
