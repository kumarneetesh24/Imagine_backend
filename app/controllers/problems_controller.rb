class ProblemsController < ApplicationController
  include Response

  def index
    @problems = Problem.active
    json_response(@problems)
  end

  def problem
    pcode = params[:pcode]
    @problem = Problem.by_pcode(pcode).first
    json_response({ error: '404 not found' }, 404) && return if @problem.state == false
    json_response(@problem)
  end
end
