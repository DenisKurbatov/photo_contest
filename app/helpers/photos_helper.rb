module PhotosHelper
  def sortable(column, title = nil)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to column, {sort: column, direction: direction}, {class: "btn"}
  end

  def sort_column
    Photo.column_names.include?(params[:sort]) ? params[:sort] : "likes_count"
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
