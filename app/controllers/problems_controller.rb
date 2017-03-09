class ProblemsController < ApplicationController

  def index
    @problems = Problem.all
    json_response(@problems)
  end

end
