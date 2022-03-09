class UserPolicy < ApplicationPolicy
  def show?
    user.role == "admin"
  end

  def edit?
    user.role == "admin"
  end

  def destroy?
    user.role == "admin"
  end

  def index?
    user.role == "admin"
  end
end
