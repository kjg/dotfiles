require 'rubygems'

begin
  require 'wirble'

  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
   require 'logger'
   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)

  # Display the RAILS ENV in the prompt
  # ie : [Development]>>
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_I => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM

end
