# frozen_string_literal: true

# Про опечатку, возможно переименвоать таблицу и везде исправить опечатку.
# Так же возможен вараинт создает алиас self.table_name = 'skills', такой  вариант не сработал,
# остался вариант, когда прописываем class_name: 'Skil'.
# первый вариант кажется более предпочтительным, так как в будущем будет меньше проблем с этим,
# изменив название таблицы и подправив название моделей.

class Skill < ApplicationRecord
  # self.table_name = 'skils' такой вариант не сработал)

  has_many :user_skills, dependent: :destroy
  has_many :users, through: :user_skills
end
