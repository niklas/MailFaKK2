require 'syslog'
module Logging
  def log(message, severity=:warning)
    Syslog.open('mailfakk2', Syslog::LOG_PID | Syslog::LOG_CONS) { |s| s.send(severity, message) }
  end
end
