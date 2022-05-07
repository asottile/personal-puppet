# frozen_string_literal: true

require 'json'
require 'ripper'

def _parse_inner(sexp)
  case sexp[0]
  when :program
    inner, = sexp[1]
    _parse_inner(inner)
  when :string_literal, :dyna_symbol
    sexp[1][1][1]
  when :@int
    sexp[1].to_i
  when :@float
    sexp[1].to_f
  when :var_ref
    { 'true' => true, 'false' => false, 'nil' => nil }[sexp[1][1]]
  when :array
    sexp[1].map { |x| _parse_inner(x) }
  when :hash
    kvs = sexp[1][1].map do |kv|
      [_parse_inner(kv[1]), _parse_inner(kv[2])]
    end
    kvs.to_h
  else
    raise "notimplemented #{sexp[0]}"
  end
end

def literal_eval(s)
  # gsettings has special integer types that don't actually matter
  s.sub!(/^uint32 /, '')
  _parse_inner(Ripper.sexp(s))
end

def run_gsettings(uid, *cmd)
  pid = `pgrep --uid asottile --newest gnome-session`.strip
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
    @resource[:name].split
  end

  def get
    schema, key = schema_key
    literal_eval(run_gsettings(@resource[:user], ['get', schema, key]))
  end

  def set
    schema, key = schema_key
    value = JSON.dump(@resource[:ensure])
    run_gsettings(@resource[:user], ['set', schema, key, value])
  end
end
