class ApplicantPolicy < ApplicationPolicy
  def create?
    user.role == "admin"
  end

  def show?
    if user.role == "admin"
      true
    else
      user.role == "chair"
    end
  end

  def destroy?
    user.role == "admin"
  end

  def index?
    user.role == "admin"
  end
end
