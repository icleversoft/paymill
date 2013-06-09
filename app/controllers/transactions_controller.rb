class TransactionsController < ApplicationController
  def index
  end
  
  def new
    @transaction = Transaction.new
  end
  
  def create
    @transaction = Transaction.new(params[:transaction])
    if @transaction.save_with_payment
      redirect_to @transaction, :notice => "Thank you for payment!"
    else
      render :new
    end
    # render :text => params.inspect
  end
  def show
    @transaction = Transaction.find(params[:id])
    
  end
end
