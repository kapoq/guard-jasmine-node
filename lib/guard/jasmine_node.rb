require 'guard'
require 'guard/guard'

module Guard
  class JasmineNode < Guard
    DEFAULT_OPTIONS = {
      :jasmine_node_bin => "jasmine-node",
      :all_after_pass   => true,
      :all_on_start     => true,
      :keep_failed      => true
    }

    autoload :Runner, "guard/jasmine_node/runner"
    
    def initialize(watchers = [], options = {})
      super(watchers, DEFAULT_OPTIONS.merge(options))
      clear_pass_state
    end

    def start
      run_all if options[:all_on_start]
    end

    def run_all
      outcome = Runner.run(["spec"], { :message => "Running all specs" })
      set_pass_state(outcome)
    end

    def run_on_change(changed_paths = [])
      run_paths = if options[:keep_failed]
                    failing_paths + changed_paths
                  else
                    changed_paths
                  end

      outcome = Runner.run(run_paths)
      set_pass_state(outcome, run_paths)
      
      if passing?
        run_all if options[:all_after_pass]
      end
    end

    def passing?
      @passing
    end

    def failing_paths
      @failing_paths
    end

    private

    def clear_pass_state
      @passing       = true
      @failing_paths = []
    end
    
    def set_pass_state(passed, run_paths = [])
      @passing = passed
      if run_paths.any?
        @failing_paths = if passing?
                           @failing_paths - run_paths
                         else
                           @failing_paths && run_paths
                         end
      end
    end
  end
end
