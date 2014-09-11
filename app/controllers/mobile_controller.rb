class MobileController < ApplicationController
  layout 'mobile'

  def nfc_show
    # {"prod_place": "\u53f0\u6e7e",
    # "image": "http://112.124.117.97/images/53a8dde7602be01173386c06",
    # "name": "\u725b\u6a1f\u83c7", "dist_place": "\u4e0a\u6d77",
    # "serial": "140620-02-01"}
    nfc_record = NfcRecord.find_by nfc_id: params[:nfc_id]
    batch = nfc_record.batch
    product = batch.product
    NfcHistory.create(batch: batch, product: product,
                      dist_place: batch.dist_place,
                      nfc_record: nfc_record,
                      client_ip: request.remote_ip)
    ret = {prod_place: product.place, image: product.image.url(:medium),
           name: product.name,
           dist_place: Paibei::PRIVINCES[batch.dist_place].last,
           serial: batch.bid}
    render json: ret
  end

  def qrcode_verify
    @qrcode_record = QrcodeRecord.find_by sn: params[:qrcode_sn]
    if @qrcode_record and @qrcode_record.left_time > 0
      batch = @qrcode_record.batch
      product = batch.product
      dist_place = batch.dist_place
      client_ip = request.remote_ip
      QrcodeHistory.create(batch: batch, product: product,
                           dist_place: dist_place, qrcode_record: @qrcode_record,
                           result: 'ok', client_ip: client_ip)
      render 'qrcode_verify'
    elsif @qrcode_record
      batch = @qrcode_record.batch
      product = batch.product
      dist_place = batch.dist_place
      client_ip = request.remote_ip
      QrcodeHistory.create(batch: batch, product: product,
                           dist_place: dist_place, qrcode_record: @qrcode_record,
                           result: 'nok', client_ip: client_ip)
      render 'qrcode_verify_failed', message: '二维码已失效'
    else
      QrcodeHistory.create(result: 'invalid', client_ip: client_ip)
      render 'qrcode_verify_failed', message: '伪造的二维码'
    end
  end

  def qrcode_verify_result
    @qrcode_record = QrcodeRecord.find_by sn: params[:qrcode_sn]
    @qrcode_record.left_time -= 1
    @qrcode_record.save
  end

  def contact_us
  end
end
