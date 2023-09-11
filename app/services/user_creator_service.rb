class UserCreatorService
  def initialize(pseudo)
    @pseudo = pseudo
  end

  def call
    if User.where(pseudo: @pseudo).exists?
      new_pseudo = generate_unique_pseudo
      user = User.create!(pseudo: new_pseudo)
      ["Le pseudo est déjà pris. Votre nouveau pseudo est #{new_pseudo}.", user]
    else
      user = User.create!(pseudo: @pseudo)
      ["Pseudo enregistré : #{@pseudo}", user]
    end
  rescue ActiveRecord::RecordInvalid => e
    [e.record.errors.full_messages.join(", "), nil]
  end

  private

  def generate_unique_pseudo
    all_pseudos = ("A".."Z").to_a.repeated_permutation(3).map(&:join)
    taken_pseudos = User.pluck(:pseudo)
    available_pseudos = all_pseudos - taken_pseudos
    available_pseudos.sample
  end
end
