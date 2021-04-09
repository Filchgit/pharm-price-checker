class StockItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
     scope.all if ( user.admin|| user.premium )
    end
  end

  def edit?
    if user.admin? || user.premium?
      true
    end
  end

  def index?
    if user.admin? || user.premium?
      true
    end
  end

  def update?
    if user.admin? || user.premium?
      true
    end
  end

  def self?
    if user.admin? || user.premium?
      true
    end
  end

  def upload?
    if user.admin? || user.premium?
      true
    end
  end

  def compare?
    if user.admin? || user.premium?
      true
    end
  end
end
