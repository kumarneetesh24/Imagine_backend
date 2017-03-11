class Language < ApplicationRecord
  scope :by_lang, -> (lang_code){ where(lang_code: lang_code)   }
end
