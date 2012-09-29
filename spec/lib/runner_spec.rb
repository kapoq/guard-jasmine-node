require 'spec_helper'

describe Guard::JasmineNode::Runner do
  let(:runner) { Guard::JasmineNode::Runner }

  before do
    Open3.stub(:popen3 => "response")
  end
  
  describe ".run" do
    context "when passed no paths" do
      it "returns false" do
        runner.run.should be_false
      end
    end

    context "when passed paths" do
      let(:some_paths) { %w(/foo/bar /zip/zap) }

      it "executes jasmine node" do
        Open3.should_receive(:popen3).with(/__EXECUTABLE__/)
        runner.run(some_paths, :jasmine_node_bin => "__EXECUTABLE__")
      end

      it "passes the paths to the executable" do
        Open3.should_receive(:popen3).with(/#{some_paths.join(" ")}/)
        runner.run(some_paths)
      end

      context "and coffeescript option is true" do
        it "passes the --coffee option to jasmine node" do
          Open3.should_receive(:popen3).with(/--coffee/)
          runner.run(some_paths, :coffeescript => true)
        end
      end

      context "and coffeescript option is false" do
        it "does not pass the --coffee option to jasmine node" do
          Open3.should_not_receive(:popen3).with(/--coffee/)
          runner.run(some_paths, :coffeescript => false)
        end
      end
      
      context "and verbose option is true" do
        it "passes the --verbose option to jasmine node" do
          Open3.should_receive(:popen3).with(/--verbose/)
          runner.run(some_paths, :verbose => true)
        end
      end
      
      context "and verbose option is false" do
        it "does not pass the --verbose option to jasmin node" do
          Open3.should_not_receive(:popen3).with(/--verbose/)
          runner.run(some_paths, :verbose => false)
        end
      end

      it "returns IO object" do
        io_obj = double("io obj")
        Open3.stub(:popen3 => io_obj)
        runner.run(some_paths).should eql io_obj
      end
      
      context "when message option is given" do
        it "outputs message" do
          Guard::UI.should_receive(:info).with("hello", anything)
          runner.run(some_paths, :message => "hello")
        end
      end

      context "when no message option is given" do
        context "and running all specs" do
          let(:all_paths) { %w(foo bar zap) }
          
          it "outputs message confirming all specs are being run" do
            Guard::UI.should_receive(:info).with("Running all specs", anything)
            runner.run(all_paths, spec_paths: all_paths)
          end
        end

        context "and running some specs" do
          it "outputs paths of specs being run" do
            Guard::UI.should_receive(:info).with("Running: /foo/bar /zip/zap", anything)
            runner.run(some_paths)
          end
        end
      end
    end
  end
end
