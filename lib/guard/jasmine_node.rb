require 'guard'
require 'guard/guard'

module Guard
  class JasmineNode < Guard
    DEFAULT_OPTIONS = {
      :jasmine_node_bin => "jasmine-node",
      :all_after_pass   => true,
      :all_on_start     => true,
      :keep_failed      => true,
      :notify           => true,
      :coffeescript     => true,
      :verbose          => true
    }
    
    PATHS_FOR_ALL_SPECS = %w(spec)

    autoload :Runner,    "guard/jasmine_node/runner"
    autoload :SpecState, "guard/jasmine_node/spec_state"

    def initialize(watchers = [], options = {})
      super(watchers, DEFAULT_OPTIONS.merge(options))
      @state = SpecState.new
    end

    def start
      run_all if options[:all_on_start]
    end

    def run_all
      run(PATHS_FOR_ALL_SPECS)
      notify(:all)
    end

    def run_on_change(changed_paths = [])
      run_paths = if options[:keep_failed]
                    failing_paths + changed_paths
                  else
                    changed_paths
                  end

      run(run_paths)
      notify(:some)

      run_all if passing? and options[:all_after_pass]
    end

    def failing_paths
      @state.failing_paths
     end

    def passing?
      @state.passing?
    end

    def fixed?
      @state.fixed?
    end

    private

    def run(run_paths = [], runner_options = {}, notifications = {})
      @state.update(run_paths, options.merge(runner_options))
    end

    def notify(scope = :all)
      return unless options[:notify]
      
      message = if passing?
                  if fixed?
                    scope == :all ? "All fixed" : "Specs fixed"
                  else
                    scope == :all ? "All specs pass" : "Specs pass"
                  end
                else
                  "Some specs failing"
                end
      image = passing? ? :success : :failed
      ::Guard::Notifier.notify(message, :image => image, :title => "jasmine-node")
    end
  end
end
