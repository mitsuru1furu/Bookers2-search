class SearchController < ApplicationController
  def search
	method = params[:search_method]
    method2 = params[:search_method2]
    word = params[:search_word]
    if method == 'book'
    	@books = Book.search(method,method2,word)
    elsif method == 'user'
    	@users = User.search(method,method2,word)
    end
    @book = Book.new
	   
  end
end
