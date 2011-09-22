require 'guard/ui'

module Guard
  class JasmineNode
    module Runner
      def self.run(paths = [], options = {})
        return false if paths.empty?
        
        message = options.fetch(:message, "Running: #{paths.join(' ')}")
        ::Guard::UI.info(message, :reset => true)

        system(jasmine_node_command(paths, options))
      end

      private

      def self.jasmine_node_command(paths = [], options = {})
        "#{options[:jasmine_node_bin]} #{paths.join(' ')}"
      end
    end
  end
end
