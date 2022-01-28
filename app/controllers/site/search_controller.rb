class Site::SearchController < SiteController
  def questions
    @questions = Question.search(params[:term])
  end
end
