require 'test_helper'

class UserTest < ActiveSupport::TestCase

def setup
  @user =User.new(name: "bittu",email: "bittu@moldedbits.com",
                                password: "foobar", password_confirmation: "foobar")
    end

test "should be valid" do
  assert @user.valid?
 end

#test "email should be present" do
 # @user.email = " "
  #assert_not @user.valid?
#end

test "name should be present" do
  @user.name = " "
  assert_not @user.valid?
 end

test "name should not be too long" do
  @user.name = "a"*51
  assert_not @user.valid?
 end

test "email should not be too long" do
  @user.email = "a"*244 +"@moldedbits"
  assert_not @user.valid?
 end

test "email validation should accept valid addresses" do
  valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                                        first.last@foo.jp alice+bob@baz.cn]
  valid_addresses.each do |valid_address|
    @user.email = valid_address
    assert @user.valid?, "#{valid_address.inspect} should be valid"
   end
 end

test "email valid should reject invalid addresses" do
  invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]

  invalid_addresses.each do |invalid_address|
    @user.email = invalid_address
    assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
   end
 end

test "email addresses should be unique" do
  duplicate_user = @user.dup
  duplicate_user.email = @user.email.upcase
  @user.save
  assert_not duplicate_user.valid?
 end

test "password should have a minimum length" do
  @user.password = @user.password_confirmation = "a"*5
  assert_not @user.valid?
 end

test "authenticated? should return false for a user with nil digest" do
  assert_not @user.authenticated?(:remember, '')
 end

 test "associated microposts should be destroyed" do
   @user.save
   @user.microposts.create!(content: "Lorem ipsum")
   assert_difference 'Micropost.count', -1 do
     @user.destroy
   end
 end

 test "should follow and unfollow a user" do
   dinesh = users(:dinesh)
   gunjan = users(:gunjan)
   assert_not dinesh.following?(gunjan)
   dinesh.follow(gunjan)
   assert dinesh.following?(gunjan)
   assert gunjan.followers.include?(dinesh)
   dinesh.unfollow(gunjan)
   assert_not dinesh.following?(gunjan)
 end

 test "feed should have the right posts" do
   dinesh = users(:dinesh)
   gunjan = users(:gunjan)
   anuj = users(:anuj)

   # Posts from followed user
   anuj.microposts.each do |post_following|
     assert dinesh.feed.include?(post_following)
   end

   #posts from self
   dinesh.microposts.each do |post_self|
     assert dinesh.feed.include?(post_self)
   end

   # Posts from unfollowed user
   gunjan.microposts.each do |post_unfollowed|
     assert_not dinesh.feed.include?(post_unfollowed)
   end
 end
end
