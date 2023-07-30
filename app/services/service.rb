class Service < Actor
  # @!attribute output
  #   @return [Any] the result of the service call
  output :output

  def _call
    self.output = call
  end
end
