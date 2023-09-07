class UsersController < ApplicationController
  # Désactive la vérification du token CSRF uniquement pour l'action `create`.
  skip_before_action :verify_authenticity_token, only: [:create]

  # Action pour afficher le formulaire de création d'un nouvel utilisateur.
  def new
    @user = User.new
  end

  # Action pour créer un nouvel utilisateur.
  def create
    # Récupère le pseudo depuis les paramètres, le met en majuscules et supprime les espaces.
    pseudo = params[:user][:pseudo].try(:strip).try(:upcase)
    message = ""

    # Vérifie si le pseudo est valide.
    if pseudo.present? && pseudo.match?(/^[A-Z]{3}$/)
      # Vérifie si le pseudo existe déjà.
      if User.where(pseudo: pseudo).exists?
        # Génère un pseudo unique si le pseudo est déjà pris.
        new_pseudo = generate_unique_pseudo
        user = User.create!(pseudo: new_pseudo)
        message = "Le pseudo est déjà pris. Votre nouveau pseudo est #{new_pseudo}."
      else
        # Crée un nouvel utilisateur avec le pseudo donné.
        user = User.create!(pseudo: pseudo)
        message = "Pseudo enregistré : #{pseudo}"
      end
    end

    # Répond en HTML ou JSON selon la requête.
    respond_to do |format|
      if user && user.valid?
        flash[:notice] = message
        format.html { redirect_to new_user_path, notice: flash[:notice] }
        format.json { render json: { pseudo: user.pseudo, message: message }, status: :created }
      else
        message = "Pseudo invalide : pseudo de 3 lettres majuscules uniquement !"
        format.html { redirect_to new_user_path, alert: message }
        format.json { render json: { error: "Invalid pseudo", message: message }, status: :bad_request }
      end
    end
  end

  private

  # Méthode pour générer un pseudo unique.
  def generate_unique_pseudo
    loop do
      pseudo = ("A".."Z").to_a.sample(3).join
      break pseudo unless User.where(pseudo: pseudo).exists?
    end
  end
end
