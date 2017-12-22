require 'cgi'
require 'digest'
require 'net/http'

def download_and_verify(uri, path, sha256)
  open path, 'wb' do |io|
    Net::HTTP.get_response uri do |resp|
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
  has_feature :versionable

  commands gdebi: '/usr/bin/gdebi'

  def install
    raise ArgumentError, 'Specify url as `source`' unless @resource[:source]
    uri = URI(@resource[:source])
    sha256 = CGI.parse(uri.fragment)['sha256'][0]
    Dir.mktmpdir('gdebi-download') do |dir|
      deb = File.join(dir, "#{@resource[:name]}.deb")
      download_and_verify(uri, deb, sha256)
      gdebi('-n', deb)
    end
  end
end
