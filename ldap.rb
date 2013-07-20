require 'rubygems'
require 'ldap'
require 'config'

# Attempt to login to LDAP.
# If login successful, return uid
# else return False
def login(user, pass)
  conn = LDAP::Conn.new($ldap_conf[:server], $ldap_conf[:port])
  conn.set_option( LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )
  conn.start_tls
  puts user + $ldap_conf[:people_dn]
  conn.bind('uid=' + user + ',' + $ldap_conf[:people_dn], pass)
end



def get_uid(ldap, user)
  ldap.search(:base => $ldap_conf[:people_dn], :filter => "(cn=#{user})") do |entry|
    entry['uidNumber']
  end
end
