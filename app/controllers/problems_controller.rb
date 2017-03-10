class ProblemsController < ApplicationController
  include Response

  def index
    @problems =  Problem.all
    json_response(@problems)
  end

  def problem
    pcode = params[:pcode]
    @problem = Problem.by_pcode(pcode).first
    json_response(@problem)
  end
end
