class PharmacyStockItemPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
     false
    end
  end

  def index?
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
