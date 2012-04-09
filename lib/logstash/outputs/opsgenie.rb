require "logstash/outputs/base"
require "logstash/namespace"
require "uri"
require "net/http"
require "net/https"

# Ugly monkey patch to get around <http://jira.codehaus.org/browse/JRUBY-5529>
Net::BufferedIO.class_eval do
    BUFSIZE = 1024 * 16

    def rbuf_fill
      timeout(@read_timeout) {
        @rbuf << @io.sysread(BUFSIZE)
      }
    end
end


class LogStash::Outputs::OpsGenie < LogStash::Outputs::Base

  config_name "opsgenie"
  plugin_status "beta"

  # your opsgenie host
  config :host, :validate => :string,  :default => "alerts.opsgenie.com"
  config :key, :validate => :string, :required => true
  config :proto, :validate => :string, :default => "http"

  public
  def register
    # nothing to do
  end 

  public
  def receive(event)
    return unless output?(event)
    if event == LogStash::SHUTDOWN
      finished
      return
    
  end 
end # class LogStash::Outputs::OpsGenie
