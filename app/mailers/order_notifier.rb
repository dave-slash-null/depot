class OrderNotifier < ActionMailer::Base
  default from: "Dave <emailmaster@slayeralbums.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order
    @greeting = "SLAYER!!!!"

    mail to: order.email, subject: "Slayer Album Order Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
