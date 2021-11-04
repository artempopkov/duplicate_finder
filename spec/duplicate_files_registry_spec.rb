require_relative '../lib/sha256_file_digester'
require_relative '../lib/duplicate_files_registry'

require 'tempfile'

describe DuplicateFilesRegistry do
  let(:registry) { DuplicateFilesRegistry.new(Sha256FileDigester.new, File::NULL) }

  context 'when adding new files to registry' do
    context 'adds file' do
      it do
        registry.add_file(Tempfile.new.path)
        expect(registry.count_files).to eq 1
      end
    end

    context 'adds two files' do
      it do
        registry.add_files([Tempfile.new.path, Tempfile.new.path])
        expect(registry.count_files).to eq 2
      end
    end
  end

  context 'each method' do
    before { allow(registry).to receive(:duplicate_files).and_return({ a: %w[1.png 2.png], b: ['3.png'] }) }

    it 'iterates over all duplicates in the registry' do
      result = []
      registry.each { |duplicates| result << duplicates }
      expect(result).to eq [%w[1.png 2.png], ['3.png']]
    end
  end

  context 'count methods' do
    before do
      allow(registry).to receive(:files).and_return([1, 3])
      allow(registry).to receive(:duplicate_files).and_return({ a: %w[1.png 2.png] })
    end

    it 'gives information about files amount in the registry' do
      expect(registry.count_files).to eq 2
    end

    it 'gives information about duplicates amount in the registry' do
      expect(registry.count_duplicates).to eq 1
    end
  end

  context 'emptiness check method' do
    context 'when registry is empty' do
      it do
        expect(registry.empty?).to be true
      end
    end

    context 'when registry is not empty' do
      before { allow(registry).to receive(:duplicate_files).and_return({ a: %w[1.png 2.png] }) }

      it do
        expect(registry.empty?).to be false
      end
    end
  end
end
