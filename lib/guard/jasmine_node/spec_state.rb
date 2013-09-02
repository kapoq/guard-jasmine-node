module Guard
  class JasmineNode
    class SpecState
      STDIN  = 0
      STDOUT = 1
      STDERR = 2
      THREAD = 3

      SUCCESS_CODE = 0
      ERROR_CODE   = 1

      attr_accessor :failing_paths
      
      def initialize
        clear!
      end

      def update(run_paths = [], options = {})
        @run_paths = run_paths
        @io = Runner.run(@run_paths, options)
        @stdout     = @io[STDOUT]
        @stderr     = @io[STDERR]
        @exitstatus = @io[THREAD].value rescue ERROR_CODE
        @stderr.each_line { |line| print line }
        @stdout.each_line { |line| print line }
        close_io
        update_passed_and_fixed
        update_failing_paths
        passing?
      end
      
      def passing?
        @passed
      end

      def fixed?
        @fixed
      end
      
      def clear!
        @passed = true
        @fixed  = false
        @failing_paths = []
      end

      private

      def close_io
        @io[STDIN..STDERR].each { |s| s.close }
      end

      def update_passed_and_fixed
        previously_failed = !passing?
        @passed = @exitstatus == SUCCESS_CODE
        @fixed  = @passed && previously_failed 
      end
      
      def update_failing_paths
        if @run_paths.any?
          @failing_paths = if passing?
                             @failing_paths - @run_paths
                           else
                             @failing_paths + @run_paths
                           end.uniq
        end
      end
    end
  end    
end
