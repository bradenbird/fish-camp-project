class ApplicantPolicy < ApplicationPolicy
  def create?
      if (user.role == "admin") 
          return true
      else 
          return false
      end
  end
  
  def show?
      if (user.role == "admin")
          return true
      elsif (user.role == "chair")
          return true
      else 
          return false 
      end
  end
end 