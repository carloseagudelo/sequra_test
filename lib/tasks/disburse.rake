namespace :disbursement do

  # Daily schedule notifications
  task weekly_task: :environment do
    Rails.logger.info "weekly disburse starting..."
    DisbursementWorker.perform_async
    Rails.logger.info "weekly disburse starting..."
  end
  
end