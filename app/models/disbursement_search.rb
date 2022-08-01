# frozen_string_literal: true

class DisbursementSearch

  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  def initialize(attributes={})
    @merchant_id = attributes['merchant_id']
    @from = attributes['from']
    @to = attributes['to']
  end

  after_validation :change_dates

  attr_accessor :merchant_id, :from, :to

  validate :merchant_id_validation, :from_validation, :to_validation

  def merchant_id_validation
    return if self.merchant_id.blank?
    errors.add(:merchant_id, "merchant_id should be a valid value") if !merchant_id.to_i.to_s.eql? self.merchant_id.to_s
  end

  def from_validation
    return if @from.blank?
    errors.add(:from, "Should be a date") if validate_date(@from).nil? 
  end

  def to_validation
    return if @to.blank?
    errors.add(:to, "Should be a date") if validate_date(@to).nil?
  end

  def validate_date(sting_date)
    begin 
      DateTime.parse(sting_date)
    rescue 
      nil
    end
  end

  def change_dates
    return if errors.present?
    @from = @from.present? ? DateTime.parse(@from).beginning_of_day : (DateTime.now - 7.days).beginning_of_day
    @to = @to.present?.present? ? DateTime.parse(@to).end_of_day : DateTime.now.end_of_day
  end

end
