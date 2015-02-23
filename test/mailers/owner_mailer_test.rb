require 'test_helper'

class OwnerMailerTest < ActionMailer::TestCase
  test "welcome" do
    mail = OwnerMailer.welcome
    assert_equal "Welcome", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "invite_friends" do
    mail = OwnerMailer.invite_friends
    assert_equal "Invite friends", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
