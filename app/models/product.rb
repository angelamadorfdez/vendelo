class Product < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B',
  }

  ORDER_BY = {
    newest: "created_at DESC",
    cheaper: "price ASC",
    more_expensive: "price DESC"
  }

  belongs_to :category
  
  has_one_attached :photo

  validates :title, presence: true # Valida la existencia de este campo en el formulario a NIVEL DE LA APLICACIÓN, PERO NO EN LA BASE DE DATOS. Esto último lo haremos con una migración
  validates :description, presence: true
  validates :price, presence: true

end
