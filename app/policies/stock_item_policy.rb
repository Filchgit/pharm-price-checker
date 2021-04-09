class StockItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.premium?
         scope.all
      end
    end
  end

  def edit?
    if user.admin? || user.premium?
      true
    end
  end

end
