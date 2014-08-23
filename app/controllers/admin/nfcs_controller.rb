class Admin::NfcsController < ApplicationController
  def create
    @batch = Batch.find(params[:batch_id])
    for nfc_id in params[:nfc_file]
      nfc_id.strip!.downcase!
      @batch.nfc_records.create(:nfc_id => nfc_id)
      redirect_to admin_batch_path(@batch)
    end
  end

  def index
  end

  def destroy
  end

  def show
  end
end
