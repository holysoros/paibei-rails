class Admin::BatchesController < ApplicationController
  def new
    @product = Product.find(1)
    @batch = Batch.new(product: @product, dist_place: 0, verify_time: 1)
  end

  def create
    @batch = Batch.new(batch_params)
  
    if @batch.save
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
end
