require 'rubygems'
require 'ldap'
require 'config'

# Attempt to login to LDAP.
# If login successful, return uid
# else return False
def login(user, pass)
  conn = LDAP::Conn.new($ldap_conf[:server], $ldap_conf[:port])
  conn.set_option(LDAP::LDAP_OPT_PROTOCOL_VERSION, 3)
  conn.start_tls

  begin
    if conn.bind('uid=' + user + ',' + $ldap_conf[:people_dn], pass)
      get_uidNumber conn, user
    else
      False
    end
  rescue Exception => e
    nil
  end
end


def get_uidNumber(conn, user)
  conn.search($ldap_conf[:people_dn], 1 ,"(uid=#{user})") do |entry|
    entry['uidNumber'].to_s
  end
end
