module ApplicationHelper
  def get_navtype
    return case request.original_url.match(/^[^\/]+\/\/[^\/]+\/([^\/]+)/).try(:[],1)
    when "greddit" then "greddit_"
    else ""
    end
  end
end
