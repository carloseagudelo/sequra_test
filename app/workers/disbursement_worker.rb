class DisbursementWorker
  include Sidekiq::Worker
  sidekiq_options queue: :disbursement

  def perform(merchant_id=nil, from=nil, to=nil)
    disbursed = []

    Order.to_disburse(DisbursementSearch.new).find_in_batches(batch_size: 100) do |order_batch|
      order_batch.each do |order|
        logger.info "Disbursement with id = #{order_id} start"
        next if order.disburse?
        disbursed << order if order.disburse!
        logger.info "Disbursement with id = #{order_id} end"
      end
    end
    #TODO I saved disbursed array with orders disbursed done to make anything like (notify, report, etc) after finish
  end
end
