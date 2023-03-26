class ChallengePolicy < ApplicationPolicy
  attr_reader :user, :record
  def initialize(user, record)
    @user =Current.user
    @record = record
  end
  def destroy?
    #if the user is an admin or the owner of the company,
    # they can access the delete action”.
    @user.role == 'admin' || @record.user == @user
  end
  def create?
    @user.role == 'level1' || @user.role == 'level2' || @user.role == 'company' || @user.role == 'admin'
  end 
end