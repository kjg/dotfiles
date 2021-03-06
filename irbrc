if defined?(::Bundler)
  $LOAD_PATH.concat Dir.glob("#{ENV['rvm_path']}/gems/#{ENV['rvm_ruby_string']}@global/gems/*/lib")
end

require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000

if defined?(::Rails)
  IRB.conf[:HISTORY_FILE] = File.join(ENV['PWD'], '.irb-history')
else
  IRB.conf[:HISTORY_FILE] = File.join(ENV['HOME'], '.irb-history')
end


def set_custom_prompt(prompt_prefix = File.basename(Dir.pwd))
  ruby_version = "#{RUBY_ENGINE rescue 'ruby'}-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "[ #{ruby_version} ][ #{prompt_prefix}:%03n:%i ] >>  ",
   :PROMPT_I => "[ #{ruby_version} ][ #{prompt_prefix}:%03n:%i ] >> ",
   :PROMPT_S => "[ #{ruby_version} ][ #{prompt_prefix}:%03n:%i ]%l>? ",
   :PROMPT_C => "[ #{ruby_version} ][ #{prompt_prefix}:%03n:%i ] >? ",
   :RETURN => "=> %s\n"
   }

  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

rails_env = (ENV['RAILS_ENV'] rescue nil) || (Rails.env rescue nil)
if rails_env
  # do all this after Rails is loaded
  IRB.conf[:IRB_RC] = Proc.new do |context|
    if defined?(Rails) && defined?(Rails.application)
      prompt_prefix = Rails.application.class.to_s.split("::").first
    elsif defined?(RAILS_ROOT)
      prompt_prefix = File.basename(RAILS_ROOT).capitalize
    else
      prompt_prefix = File.basename(Dir.pwd).capitalize
    end

    prompt_prefix << ":#{rails_env.capitalize}"

    ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)
    context.prompt_mode = set_custom_prompt(prompt_prefix)
  end
end

set_custom_prompt
