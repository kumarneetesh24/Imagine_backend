class CreateLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string "lang_code",        null: false
      t.string "equal"
      t.string "greater"
      t.string "smaller"
      t.string "double_equals"
      t.string "and"
      t.string "or"
      t.string "int"
      t.string "string"
      t.string "print"
      t.string "read"
      t.string "function"
      t.string "return"
      t.string "if_else"
      t.string "for"
      t.string "while"
      t.string "do_while"
      t.string "switch"
      t.string "continue"
      t.string "break"
      t.string "start_bkt"
      t.string "end_bkt"
      t.timestamps
    end
  end
end
