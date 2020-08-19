module NotificationHelper

  def self.send_sms(destNumber, message)
    sns = Aws::SNS::Client.new(region:'us-east-1', credentials: Aws::Credentials.new(ENV["AWS-KEY-1"], ENV["AWS-KEY-2"]))
    sns.publish(phone_number: destNumber, message: message)
  end

  def send_sms(destNumber, message)
    self.send_sms(destNumber, message)
  end
end
