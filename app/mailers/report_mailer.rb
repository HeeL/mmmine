class ReportMailer < ActionMailer::Base
  helper :application

  default from: 'no-reply@mmmine.com'
  default to: ENV['REPORT_EMAILS'].split(',')
 
  def send_report(product_id, reason)
    @product_id = product_id
    @reason = reason
    mail(subject: "[mmmine] User reported on a product!")
  end

end