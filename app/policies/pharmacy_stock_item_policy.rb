class PharmacyStockItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      false
    end
  end

  def index?
    true if user.admin? || user.premium?
  end

  def upload?
    true if user.admin? || user.premium?
  end

  def compare?
    true if user.admin? || user.premium?
  end

end
