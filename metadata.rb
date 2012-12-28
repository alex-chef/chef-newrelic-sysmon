maintainer       "Trond Arve Nordheim"
maintainer_email "t@binarymarbles.com"
license          "Apache 2.0"
description      "Installs and configures NewRelic server monitoring agent."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

%w(ubuntu debian).each do |platform|
  supports platform
end

recipe           "newrelic_sysmon", "Installs and configures the NewRelic server monitoring agent."

attribute "newrelic_sysmon",
  :display_name => "NewRelic Sysmon",
  :description => "Hash of NewRelic Sysmon attributes.",
  :type => "hash"

attribute "newrelic_sysmon/license_key",
  :display_name => "License key",
  :description => "NewRelic RPM license key",
  :default => ""
