NAME_RE = /^[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)* [a-zA-Z0-9_-]+$/

def _bool_to_puppet(b)
  { true => ':true', false => ':false', nil => ':nil' }.fetch(b, b)
end

def _puppet_to_bool(s)
  { ':true' => true, ':false' => false, ':nil' => nil }.fetch(s, s)
end

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
      _bool_to_puppet(@resource.provider.get)
    end

    def insync?(is)
      @rawvalue == is
    end

    def should_to_s(*)
      self.class.format_value_for_display(@rawvalue)
    end

    def value
      _puppet_to_bool(@rawvalue)
    end

    def value=(x)
      @rawvalue = x
      super
    end
  end

  newparam(:user)
end
