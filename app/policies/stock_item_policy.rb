class StockItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      false
      # scope.all if user.admin || user.premium
      # Not sure what this resolve is doing but pharmacy stock items is false and they are working
    end
  end

  def edit?
    true if user.admin? || user.premium?
  end

  def index?
    true if user.admin? || user.premium?
  end

  def update?
    true if user.admin? || user.premium?
  end

  def self?
    true if user.admin? || user.premium?
  end

  def upload?
    true if user.admin? || user.premium?
  end

  def compare?
    true if user.admin? || user.premium?
  end

  def csv_upload?
    true if user.admin?
  end

  def download?
    true if user.admin? || user.premium?
  end


end
