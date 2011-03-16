require 'rubygems'

begin
  require 'wirble'

  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

promt_prefix = nil

rails_env = (ENV['RAILS_ENV'] rescue nil) || (Rails.env rescue nil)
if rails_env
  if defined?(Rails) && Rails.application
    promt_prefix = Rails.application.class.to_s.split("::").first
  else
    promt_prefix = File.basename(Dir.pwd).capitalize
  end

  promt_prefix << ":#{rails_env.capitalize}"

  IRB.conf[:IRB_RC] = Proc.new do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
end

promt_prefix ||= File.basename(Dir.pwd)

IRB.conf[:PROMPT][:CUSTOM] = {
 :PROMPT_N => "[ #{promt_prefix}:%03n:%i ] >>  ",
 :PROMPT_I => "[ #{promt_prefix}:%03n:%i ] >> ",
 :PROMPT_S => "[ #{promt_prefix}:%03n:%i ]%l>? ",
 :PROMPT_C => "[ #{promt_prefix}:%03n:%i ] >? ",
 :RETURN => "=> %s\n"
 }
# Set default prompt
IRB.conf[:PROMPT_MODE] = :CUSTOM
