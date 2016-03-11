require 'gpgenv'
require 'shellwords'
require 'clamp'

module Gpgenv
  class ExportCommand  < Clamp::Command

    option ['-f', '--force'], :flag, "Force overwrite of existing .env file"

    def execute
      if File.exist?('.env') && !force?
        fail(".env file already exists. Use --force to overwrite it.")
      end

      File.open('.env', 'w') do |f|
        Gpgenv.read_files.each do |k, v|
          f.write "#{k}=#{Shellwords.escape(v)}"
        end
      end
    end

  end
end
