class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = Current.user
    @record = record
  end

  def destroy?
    #if the user is an admin or the owner of the company,
    # they can access the delete action”.
    @user.role == 'admin' || @record.id == @user.id
  end
  def update?
    @user.role == 'admin' || @record.id == @user.id
  end
end