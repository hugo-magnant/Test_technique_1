class UserCreatorService
  INVALID_PSEUDO_MESSAGE = "Pseudo invalide : pseudo de 3 lettres majuscules uniquement !"

  def initialize(pseudo)
    @pseudo = pseudo
  end

  def call
    user = User.new(pseudo: @pseudo)
    if user.valid?
      user.save!
      ["Pseudo enregistré : #{@pseudo}", user]
    elsif User.where(pseudo: @pseudo).exists?
      new_pseudo = generate_unique_pseudo
      user = User.create!(pseudo: new_pseudo)
      ["Le pseudo est déjà pris. Votre nouveau pseudo est #{new_pseudo}.", user]
    else
      [INVALID_PSEUDO_MESSAGE, nil]
    end
  end

  private

  def generate_unique_pseudo
    loop do
      new_pseudo = Array.new(3) { ("A".."Z").to_a.sample }.join
      return new_pseudo unless User.where(pseudo: new_pseudo).exists?
    end
  end
end
