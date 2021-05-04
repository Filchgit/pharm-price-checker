class SettingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    true if user.admin? || user.premium?
  end

  def update?
    true if user.admin? || user.premium?
  end
end
