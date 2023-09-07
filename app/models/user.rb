class User < ApplicationRecord
  # Valide la présence du pseudo, sa longueur (doit être de 3 caractères) et son unicité.
  validates :pseudo, presence: true, length: { is: 3 }, uniqueness: true
  # Valide que le pseudo ne contient que des lettres majuscules.
  validates_format_of :pseudo, with: /\A[A-Z]+\z/
end
