class Site::SearchController < SiteController
  def questions
    # params[:term]
    # @questions = Question.all
    @questions = Question.includes(:answers)
                         .where("lower(description) LIKE ? ",  "%#{params[:term].downcase}%")
  end
end
