module GeoUnits
  def valid_units
    [:feet, :meters, :kms, :miles, :radians]
  end

  def valid_unit? unit
    valid_units.include? unit
  end

  # The default unit is assumed to be kms
  # This can be changed
  # Example:
  #   GeoVector.default_unit = :km

  def default_unit
    @default_unit || :kms
  end

  def default_unit= unit
    @default_unit || :kms
  end
end