require 'spec_helper'

describe Guard::JasmineNode do
  let(:guard)  { Guard::JasmineNode.new }
  let(:runner) { Guard::JasmineNode::Runner }
  
  describe "#initialize" do
    context "when no options are given" do
      it "sets a default path to jasmine-node bin" do
        guard.options[:jasmine_node_bin].should eql "jasmine-node"
      end

      it "sets a default :all_after_pass option" do
        guard.options[:all_after_pass].should be_true
      end

      it "sets a default :all_on_start option" do
        guard.options[:all_on_start].should be_true
      end
      
      it "sets a default :keep_failed option" do
        guard.options[:keep_failed].should be_true
      end

      it "is passing" do
        guard.should be_passing
      end

      it "has no failing paths" do
        guard.failing_paths.should be_empty
      end
    end

    context "when options are given" do
      let(:a_path) { "/foo/bar/jasmine-node" }
      let(:guard)  { Guard::JasmineNode.new([], {
                                              :jasmine_node_bin => a_path,
                                              :all_on_start     => false,
                                              :all_after_pass   => false,
                                              :keep_failed      => false
                                            }) }

      it "sets the path to jasmine-node bin" do
        guard.options[:jasmine_node_bin].should eql a_path        
      end
      
      it "sets the :all_after_pass option" do
        guard.options[:all_after_pass].should be_false
      end

      it "sets the :all_on_start option" do
        guard.options[:all_on_start].should be_false
      end
      
      it "sets the :keep_failed option" do
        guard.options[:keep_failed].should be_false
      end
    end
  end

  describe "#start" do
    context "when :all_on_start is true" do
      it "runs all" do
        guard.should_receive(:run_all)
        guard.start
      end
    end
    
    context "when :all_on_start is false" do
      let(:guard) { Guard::JasmineNode.new([], { :all_on_start => false }) }
        
      it "does not run all" do
        guard.should_not_receive(:run_all)
        guard.start
      end
    end
  end

  describe "#run_all" do
    it "runs the runner with the spec dir" do
      runner.should_receive(:run).with(["spec"], anything)
      guard.run_all
    end

    it "tells the message to the runner" do
      runner.should_receive(:run).with(anything, hash_including(:message => "Running all specs"))
      guard.run_all
    end

    it "passes the options on to the runner" do
      an_option = { :option => "value" }
      guard.options.update(an_option)
      runner.should_receive(:run).with(anything, hash_including(an_option))
      guard.run_all
    end

    context "when specs pass" do
      before do
        runner.stub(:run => true)
        guard.run_all
      end

      it "is passing" do
        guard.should be_passing
      end

      it "has no failed paths" do
        guard.failing_paths.should be_empty
      end
    end

    context "when specs fail" do
      before do
        runner.stub(:run => false)
      end

      it "is not passing" do
        guard.run_all
        guard.should_not be_passing
      end

      it "keeps previously failing specs" do
        failing_paths = %w(foo bar)
        guard.run_on_change(failing_paths)
        guard.run_all
        guard.failing_paths.should eql failing_paths
      end
    end
  end

  describe "#run_on_change" do
    it "runs the runner with paths" do
      runner.should_receive(:run).with(["/a/path"], anything)
      guard.run_on_change(["/a/path"])
    end

    it "passes options through to the runner" do
      an_option = { :option => "value" }
      guard.options.update(an_option)
      runner.should_receive(:run).with(anything, hash_including(an_option))
      guard.run_on_change
    end

    context "when specs pass" do
      before do
        runner.stub(:run => true)
      end

      it "is passing" do
        guard.run_on_change
        guard.should be_passing
      end
      
      context "and :all_after_pass is true" do
        before do
          guard.options[:all_after_pass] = true
        end

        it "runs all" do
          guard.should_receive(:run_all)
          guard.run_on_change
        end
      end
      
      context "and :all_after_pass is false" do
        before do
          guard.options[:all_after_pass] = false
        end

        context "if :all_after_pass is true" do
          it "does not run all" do
            guard.should_not_receive(:run_all)
            guard.run_on_change
          end
        end
      end
    end

    context "when specs fail" do
      before do
        runner.stub(:run => false)
      end

      it "is not passing" do
        guard.run_on_change
        guard.should_not be_passing
      end
    end

    context "when there are failing paths" do
      let(:failing_paths) { %w(foo/bar zip/zap) }
      let(:changed_paths) { %w(aaa/bbb ccc/ddd) }
      let(:all_paths)     { failing_paths + changed_paths }
      
      before do
        guard.stub(:failing_paths => failing_paths)
      end
      
      context "and :keep_failed is true" do
        before do
          guard.options[:keep_failed] = true
        end

        it "runs the runner failing paths and the changed paths" do
          runner.should_receive(:run).with(all_paths, anything)
          guard.run_on_change(changed_paths)
        end
      end
      
      context "and :keep_failed is false" do
        before do
          guard.options[:keep_failed] = false
        end

        it "runs the runner with only the changed paths" do
          runner.should_receive(:run).with(changed_paths, anything)
          guard.run_on_change(changed_paths)
        end
      end
    end
  end
end
