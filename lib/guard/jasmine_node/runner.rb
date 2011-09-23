require 'open3'
require 'guard/ui'

module Guard
  class JasmineNode
    module Runner
      def self.run(paths = [], options = {})
        return false if paths.empty?

        @paths   = paths
        @options = options

        print_message
        execute_jasmine_node_command
      end

      private

      def self.print_message
        message = @options[:message]
        message ||= @paths == PATHS_FOR_ALL_SPECS ? "Running all specs" : "Running: #{@paths.join(' ')}"
        ::Guard::UI.info(message, :reset => true)
      end

      def self.execute_jasmine_node_command
        ::Open3.popen3(jasmine_node_command)
      end

      def self.jasmine_node_command
        "#{@options[:jasmine_node_bin]} #{command_line_options} #{@paths.join(' ')}"
      end

      def self.command_line_options
        options = []
        options << "--coffee" if @options[:coffeescript]
        options << "--verbose" if @options[:verbose]
        options.join(" ")
      end
    end
  end
end
