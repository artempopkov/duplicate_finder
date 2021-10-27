require_relative '../lib/sha256_file_digester'
require_relative '../lib/duplicate_files_registry'

require 'rspec'

describe DuplicateFilesRegistry do
  before(:each) do
    @data_path = File.expand_path('data', __dir__)
    @registry = DuplicateFilesRegistry.new(Sha256FileDigester.new, @data_path)
  end
  
  context "when adding new files to registry" do
    before do
      File.open("#{@data_path}/10.png", 'w+')
      File.open("#{@data_path}/11.png", 'w+')
      File.open("#{@data_path}/12.png", 'w+')
    end

    after do
      File.delete("#{@data_path}/10.png")
      File.delete("#{@data_path}/11.png")
      File.delete("#{@data_path}/12.png")
    end

    it 'should add new file to the registry' do
      count_before_adding = @registry.count_files
      @registry.add_file("#{@data_path}/10.png")
      expect(@registry.count_files).to eq count_before_adding + 1 
    end

    it 'should add new files to the registry' do
      count_before_adding = @registry.count_files
      @registry.add_files(["#{@data_path}/11.png", "#{@data_path}/12.png"])
      expect(@registry.count_files).to eq count_before_adding + 2
    end
  end

  context 'each method' do
    it 'should iterate over all duplicates in the registry' do
      count = @registry.count_duplicates
      counter = 0
      @registry.each { |duplicates| counter += 1 } 
      expect(counter).to eq count
    end
  end

  context 'counts methods' do
    it 'should give information about files amount in the registry' do
      count = @registry.count_files
      expect(count).to eq 1
    end

    it 'should give information about duplicates amount in the registry' do
      count = @registry.count_duplicates
      expect(count).to eq 1
    end

    it 'should check is registry empty' do
      emptyness = @registry.empty?
      expect(emptyness).to be false
    end
  end
end
