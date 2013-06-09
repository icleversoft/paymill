class Transaction < ActiveRecord::Base
  attr_accessible :name, :email, :amount, :paymill_id, :plan_id, :paymill_card_token
  validates_presence_of :email
  validates_presence_of :amount

  # attr_accessor :paymill_card_token
  
  def save_with_payment
    if valid?
      puts "paymill_card_token:#{paymill_card_token}---------------"
      puts "email:#{email} - name:#{name}--------------------------"
      client = Paymill::Client.create email: email, description: name
      puts "Client:#{client.inspect}"
      payment = Paymill::Payment.create token: paymill_card_token, client: client.id
      puts "Payment:#{payment.inspect}-----------------------------"
     
      puts "Amount:#{self.amount} -- tof:#{amount}"
      transaction = Paymill::Transaction.create client: client.id, 
                                                amount: "#{amount.to_s.gsub('.', '')}0", 
                                                currency: 'EUR', 
                                                description: 'New Job Post', 
                                                payment: payment.id
                                                
      puts "Transaction:#{transaction.inspect}-----------------------------"
      # subscription = Paymill::Subscription.create offer: plan.paymill_id, client: client.id, payment: payment.id
      self.paymill_id = transaction.id
      save!
    end
  rescue Paymill::PaymillError => e
    logger.error "Paymill error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card. Please try again."
    false
  end

end
