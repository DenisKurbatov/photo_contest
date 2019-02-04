module Api
  class ApiController < ActionController::API
    before_action :merge_token_to_params

    def merge_token_to_params
      params.merge!(access_token: request.headers[:token])
    end

    private

    def paginate_params(list)
      paginate_list = { total_value: list.count,
                        total_pages: list.total_pages,
                        current_page: list.current_page }
      paginate_list['next_page'] = list.next_page unless list.last_page?
      paginate_list['prev_page'] = list.prev_page unless list.first_page?
      paginate_list
    end
  end
end
