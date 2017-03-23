class LanguagesController < ApplicationController
  include Response

  def index
    @languages = Language.all
    json_response(@languages)
  end

  def language
    lang_code = params[:lang_code]
    language = Language.by_lang(lang_code).first
    json_response(language)
  end
end
