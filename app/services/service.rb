class Service
  module DefaultOutput
    def _call
      self.output = super
    end
  end

  # Essential mechanics
  include(ServiceActor::Core)
  include(ServiceActor::Configurable)
  include(ServiceActor::Attributable)
  include(ServiceActor::Playable)

  # @!attribute output
  #   @return [Any] the result of the service call
  output :output

  include(DefaultOutput)

  # Extra concerns
  include(ServiceActor::Checkable)
  include(ServiceActor::Defaultable)
  include(ServiceActor::Failable)
end
