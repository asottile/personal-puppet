NAME_RE = /^[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)* [a-zA-Z0-9_-]+$/

Puppet::Type.newtype(:gsetting) do
  newparam(:name, namevar: true) do
    desc 'In the form: `SCHEMA KEY`'

    validate do |value|
      unless value.is_a?(String) && value =~ NAME_RE
        raise ArgumentError, "#{value} must be `SCHEMA KEY`"
      end
    end
  end

  newproperty(:ensure) do
    def sync
      @resource.provider.set
    end

    def retrieve
      @resource.provider.get
    end

    def insync?(is)
      @rawvalue == is
    end

    def value
      @rawvalue
    end

    def value=(x)
      @rawvalue = x
      super
    end
  end

  newparam(:user)
end
