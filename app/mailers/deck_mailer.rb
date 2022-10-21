class DeckMailer < ApplicationMailer

  before_action :set_deck

  # default to:       -> { @invitee.email_address },
  #         from:     -> { common_address(@inviter) },
  #         reply_to: -> { @inviter.email_address_with_name }

  def deck_created

    mail(
      # from: ,
      to: email_address_with_name(@deck.owner.email, @deck.owner.account.username),
      subject: "New deck created",
      # cc: ,
      # bcc: ,
      # text: "Congrats for sending test email with Mailtrap!",
      category: 'Test category',
    ) 
  end

  private

  def set_deck
    @deck = params[:deck]
  end

end
