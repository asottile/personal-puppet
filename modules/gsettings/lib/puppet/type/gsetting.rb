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
    newvalue(/./) do
      @resource.provider.set
    end

    def retrieve
      @resource.provider.get
    end
  end

  newparam(:user)
end
