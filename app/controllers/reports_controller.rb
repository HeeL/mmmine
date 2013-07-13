class ReportsController < ApplicationController
  REASONS = ['Not given', 'Not a product', 'Incorrect price', 'Bad image', 'Spam']

  def create
    ReportMailer.send_report(params[:product_id], get_reason).deliver
    render json: set_success
  end

  private

  def get_reason
    reason_num = params[:reason_num].to_i
    reason_num = 0 if reason_num > REASONS.size
    REASONS[reason_num].to_s
  end

end
