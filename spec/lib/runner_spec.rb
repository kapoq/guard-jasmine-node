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

      it "executes jasmine node with the paths" do
        Open3.should_receive(:popen3).with(/__EXECUTABLE__ #{some_paths}/)
        runner.run(some_paths, :jasmine_node_bin => "__EXECUTABLE__")
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
        it "outputs default message" do
          Guard::UI.should_receive(:info).with("Running: /foo/bar /zip/zap", anything)
          runner.run(some_paths)
        end
      end
    end
  end
end
