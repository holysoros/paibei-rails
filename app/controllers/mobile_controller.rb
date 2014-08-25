class MobileController < ApplicationController
  layout 'mobile'

  def nfc_show
    render layout: false
  end

  def qrcode_verify
    @qrcode_record = QrcodeRecord.find_by sn: params[:qrcode_sn]
    if @qrcode_record and @qrcode_record.left_time > 0
      render 'qrcode_verify'
    elsif @qrcode_record
      render 'qrcode_verify_failed', message: '二维码已失效'
    else
      render 'qrcode_verify_failed', message: '伪造的二维码'
    end
  end

  def qrcode_verify_result
  end

  def contact_us
  end
end
