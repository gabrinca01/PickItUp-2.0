class CommentPolicy < ApplicationPolicy
  def destroy?
    #if the user is an admin or the owner of the wiki,
    # they can access the delete action”.
    user.role == 'admin' || record.user == user
  end
  def create?
    user.role >= 'level2'
  end
  def edit?
     (record.user == user && user.role >= 'level1')
  end
end