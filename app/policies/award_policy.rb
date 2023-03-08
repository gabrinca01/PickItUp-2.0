class AwardPolicy < ApplicationPolicy
  def destroy?
    #if the user is an admin or the owner of the company,
    # they can access the delete action”.
    user.role == 'admin' || record.user == user
  end
end