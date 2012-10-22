require "net/https"
require "uri"
require "rubygems"
require "inifile"

def getPathToCert()
	ini = IniFile.load('config.ini')
	if ini
		path = ini['global']['cert_path']
		if path != ""
			return path
		else
			raise "Path to certificate not set, please edit the config.ini file."
		end
	end
	raise "Can't find config.ini: What have you done?!"
end

def getPathToFixtures()
	ini = IniFile.load('config.ini')
	if ini
		path = ini['global']['path_to_fixtures']
		return path
	end
end

def promptForNitroUrl()
	puts "Enter url of nitro feed: "
	return gets.chomp
end

def promptForFixturePath()
	puts "Enter path to fixture (try setting this in the config.ini to avoid being nagged): "
	return gets.chomp
end

def saveFixture(fixture_path, feed_data)
	file = File.new(fixture_path+"fix.json", "w")
	file.write(feed_data)
	file.close()
end

cert_path = getPathToCert()
uri = URI.parse(promptForNitroUrl())
pem = File.read(cert_path)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.cert = OpenSSL::X509::Certificate.new(pem)
http.key = OpenSSL::PKey::RSA.new(pem)
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

fixture_path = getPathToFixtures()
if fixture_path == ""
	fixture_path = promptForFixturePath()
end

feed = http.request(request).body
saveFixture(fixture_path, feed)

puts "Done!"