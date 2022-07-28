class Product < ApplicationRecord

  validates :title, presence: true # Valida la existencia de este campo en el formulario a NIVEL DE LA APLICACIÓN, PERO NO EN LA BASE DE DATOS. Esto último lo haremos con una migración
  validates :description, presence: true
  validates :price, presence: true

end
