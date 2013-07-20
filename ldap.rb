require 'net/ldap'
require 'config'

# Attempt to login to LDAP.
# If login successful, return uid
# else return False
def login(user, pass)
  ldap = Net::LDAP.new(:host => $ldap_conf[:server], :port => $ldap_conf[:port])

  if ldap.bind(:method => :tls, :username => user + $ldap_config[:people_dn], :password => pass)
    get_uid(ldap, user)
  else
    False
  end
end



def get_uid(ldap, user)
  ldap.search(:base => $ldap_conf[:people_dn], :filter => "(cn=#{user})") do |entry|
    entry['uidNumber']
  end
end
