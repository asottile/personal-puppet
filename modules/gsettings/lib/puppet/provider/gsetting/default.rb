require 'json'

def encode(v)
  JSON.dump(v).tr('"', "'")
end

def decode(v)
  JSON.parse(v.tr("'", '"'), quirks_mode: true)
end

def run_gsettings(uid, *cmd)
  pid = `pgrep -u #{uid} gnome-session`.strip
  envv = `grep -z DBUS_SESSION_BUS_ADDRESS /proc/#{pid}/environ`.strip
  Puppet::Util::Execution.execute(
    ['env', envv, 'gsettings', *cmd],
    failonfail: true,
    uid: uid,
    combine: true
  )
end

Puppet::Type.type(:gsetting).provide(:default) do
  commands gsettings: 'gsettings'

  def schema_key
    @resource[:name].split(' ')
  end

  def get
    schema, key = schema_key
    decode(run_gsettings(@resource[:user], ['get', schema, key]))
  end

  def set
    schema, key = schema_key
    value = encode(@resource[:ensure])
    run_gsettings(@resource[:user], ['set', schema, key, value])
  end
end
