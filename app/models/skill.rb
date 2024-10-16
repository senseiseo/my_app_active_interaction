# Про опечатку, возможно переименвоать таблицу и везде исправить опечатку.
# Так же возможен вараинт создает алиас self.table_name = 'skills'
#
class Skill < ApplicationRecord
  self.table_name = 'skils'
  has_many :users
end
