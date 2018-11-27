class Merchant < ApplicationRecord
  has_many :items

  def self.look_up(params)
    if params[:id] != nil
      find(params[:id])
    elsif params[:name] != nil
      find_by('name = ?', params[:name])
    elsif params[:created_at] != nil
      created_at = Time.zone.parse(params[:created_at])
      find_by!('created_at = ?', created_at)
    elsif params[:updated_at] != nil
      updated_at = Time.zone.parse(params[:updated_at])
      find_by("updated_at = ?", updated_at)
    end
  end

end
