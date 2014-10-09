class Admin::BatchesController < Admin::BaseController
  def new
    @product = Product.first
    @batch = Batch.new(product: @product, dist_place: 0, verify_time: 1)
  end

  def create
    @batch = Batch.new(batch_params)
  
    if @batch.save
      HardWorker.perform_async(@batch.id, @batch.product_id)

      if params[:batch][:nfc]
        import_nfc(@batch, params[:batch][:nfc])
      end

      redirect_to admin_batch_path(@batch)
    else
      render 'new'
    end
  end

  def show
    @batch = Batch.find(params[:id])
  end

  def edit
    @batch = Batch.find(params[:id])
  end

  def update
    @batch = Batch.find(params[:id])

    if @batch.update(batch_params)
      if params[:batch][:nfc]
        import_nfc(@batch, params[:batch][:nfc])
      end

      redirect_to admin_batch_path(@batch)
    else
      render 'edit'
    end
  end

  def index
    @batches = Batch.all
  end
  
  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy
  
    redirect_to admin_batches_path
  end

  private
    def batch_params
      params.require(:batch).permit(:product_id, :dist_place, :count, :verify_time)
    end

    def import_nfc(batch, nfc_file)
      for line in nfc_file.open
        nfc_id = line.strip.downcase
        batch.nfc_records.create(:nfc_id => nfc_id)
      end
    end
end
