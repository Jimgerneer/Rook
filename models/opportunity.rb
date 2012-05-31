require_relative '../rook'
#require 'dm-chunked_query'

class Rook::Opportunity 
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String
  property :skills,       String
  property :description,  String
end

DataMapper.finalize
DataMapper.auto_upgrade!

#def paginate(query) 
#  @page = (params[:page] || 1).to_i
#  @per_page =(params[:per_page] || 10).to_i
#
#  @pages = query.chunks_of(@per_page)
#  @total_count = @pages.count
#  @page_count = @pages.length
#
#  @pages[@page-1]
#end
