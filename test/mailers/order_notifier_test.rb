require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Slayer Album Order Confirmation", mail.subject
    assert_equal ["wendy@thomas.com"], mail.to
    assert_equal ["emailmaster@slayeralbums.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["emailmaster@slayeralbums.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
