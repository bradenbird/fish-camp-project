class UserPolicy < ApplicationPolicy
  
  def show?
      if (user.role == "admin")
          return true
      else 
          return false 
      end
  end
  
  def edit?
      if (user.role == "admin")
          return true
      else 
          return false 
      end
  end
  
  def destroy?
    if (user.role == "admin")
      return true
    else 
      return false
    end
  end
  
  def index?
    if (user.role == "admin")
      return true
    else 
      return false
    end
  end
  
end 