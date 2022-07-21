class ApplicationController < ActionController::API

  include Pagy::Backend

  private

  def pagy_response(pagy)
    {
      count: pagy.count,
      page: pagy.page,
      prev: pagy.prev,
      next: pagy.next,
      items: pagy.items,
      pages: pagy.pages
    }
  end

end
