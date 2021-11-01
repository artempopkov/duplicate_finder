require_relative '../lib/sha256_file_digester'
require_relative '../lib/duplicate_files_registry'

require 'rspec'
require 'tempfile'

describe DuplicateFilesRegistry do
  before(:each) do
    # @data_path = File.expand_path('data', __dir__)
    # @registry = DuplicateFilesRegistry.new(Sha256FileDigester.new, File::NULL)
  end

  let(:registry) { DuplicateFilesRegistry.new(Sha256FileDigester.new, File::NULL) }
  
  context "when adding new files to registry" do
    it 'adds new file to the registry' do
      registry.add_file(Tempfile.new.path)
      expect(registry.count_files).to eq 1 
    end

    it 'adds new files to the registry' do
      registry.add_files([Tempfile.new.path, Tempfile.new.path])
      expect(registry.count_files).to eq 2
    end
  end

  context 'each method' do
    it 'iterates over all duplicates in the registry' do
      allow(registry).to receive(:duplicate_files).and_return({a: ['1.png', '2.png'], b: ['3.png']})
      result = []
      registry.each { |duplicates| result << duplicates} 
      expect(result).to eq [["1.png", "2.png"], ["3.png"]]
    end
  end

  context 'counts methods' do
    it 'gives information about files amount in the registry' do
      allow(registry).to receive(:files).and_return([1, 3])
      expect(registry.count_files).to eq 2
    end

    it 'gives information about duplicates amount in the registry' do
      allow(registry).to receive(:duplicate_files).and_return({a: ['1.png', '2.png']})
      expect(registry.count_duplicates).to eq 1
    end

    it 'checks is registry empty' do
      expect(registry.empty?).to be true
    end
  end
end
