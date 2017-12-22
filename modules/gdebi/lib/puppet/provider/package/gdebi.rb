require 'digest'
require 'net/http'

def download_and_verify(url, path, sha256)
  open path, 'wb' do |io|
    Net::HTTP.get_response URI(url) do |resp|
      resp.read_body do |chunk|
        io.write chunk
      end
    end
  end

  sum = Digest::SHA256.file path
  return if sum.hexdigest == sha256
  raise "checksum mismatch #{sha256} #{sum.hexdigest}"
end

Puppet::Type.type(:package).provide :gdebi, parent: :dpkg do
  has_feature :package_settings, :versionable

  commands gdebi: '/usr/bin/gdebi'

  def package_settings_validate(opts)
    @sha256 = opts['sha256']
    raise ArgumentError, 'required package_setting: sha256' unless @sha256
    true
  end

  def package_settings_insync?(*)
    true
  end

  def package_settings
    @resource[:package_settings]
  end

  def install
    url = @resource[:source]
    raise ArgumentError, 'Specify the url as `source`' unless url
    Dir.mktmpdir('gdebi-download') do |dir|
      deb = File.join(dir, "#{@resource[:name]}.deb")
      download_and_verify(url, deb, @sha256)
      gdebi('-n', deb)
    end
  end
end
