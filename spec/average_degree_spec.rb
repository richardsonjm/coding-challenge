require_relative './spec_helper.rb'

describe AverageDegree do
  before do
    allow(File).to receive(:read)
    allow(File).to receive(:open)
    @average_degree = AverageDegree.new('source', 'destination', 60)
  end

  subject { @average_degree }

  context "#avg_degree" do
    it "doesn't double count existing nodes" do
      foo = 'foo'
      allow(File).to receive(:open)
      allow(File).to receive(:write)
      allow(foo).to receive(:write)
      timestamp = DateTime.strptime("Thu Oct 29 17:51:50 +0000 2015", "%a %b %d %k:%M:%S %z %Y")
      @average_degree.instance_variable_set(:@timestamp, timestamp)
      @average_degree.instance_variable_set(:@nodes, ['foo', 'bar'])
      @average_degree.instance_variable_set(:@edges, [['foo', 'bar']])
      @average_degree.instance_variable_set(:@destination, foo)
      @average_degree.avg_degree(timestamp, ['foo', 'bar'])
      expect(@average_degree.instance_variable_get(:@nodes)).to eq ['foo', 'bar']
      expect(@average_degree.instance_variable_get(:@edges)).to eq [['foo', 'bar']]
    end
  end
end
