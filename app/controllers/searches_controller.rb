class SearchesController < ApplicationController
	def tag_search
    groupings = []

    if params[:q].present?
      keywords = params[:q][:tags_name_cont].split(/[\p{blank}\s]+/)
      keywords.each { |value| groupings.push(tags_name_cont: value) }
    end

    @query = Photo.ransack(
        combinator: 'and',
        groupings: groupings
    )

    @photos = @query.result(distinct: true)

  end

end
