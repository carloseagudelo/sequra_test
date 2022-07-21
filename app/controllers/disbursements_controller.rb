class DisbursementsController < ApplicationController

  def search
    disbursement = DisbursementSearch.new(disbursement_params)
    if disbursement.valid?
      pagy, result_data = pagy(
                                  Disbursement
                                    .by_merchant(disbursement.merchant_id)
                                    .by_dates(disbursement.from, disbursement.to)
                                )
      render json: {
        data: ActiveModel::Serializer::CollectionSerializer.new(result_data, each_serializer: DisbursementSerializer),
        pagy: pagy_response(pagy)
      }, status: :ok
    else
      render json: disbursement.errors.map{|error| error.type}, status: :bad_request
    end
  end

  def massive
    disbursement = DisbursementSearch.new(disbursement_params)
    if disbursement.valid?
      DisbursementWorker.perform_async(disbursement.merchant_id, disbursement.from, disbursement.to)
      render json: :nothing, status: :ok
    else
      render json: disbursement.errors.map{|error| error.type}, status: :bad_request
    end
  end

  private

  def disbursement_params
    params.permit(:merchant_id, :from, :to)
  end

end
