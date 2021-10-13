require 'digest'
require 'folder_duplicate_files_report'

class Application
  def initialize(root_path)
    @root_path = root_path
    @data_path = File.expand_path('data', root_path)
  end

  def self.start(root_path)
    new(root_path).start
  end

  def start
    abort 'There are no file available in data folder' if files.empty?

    reporter = FolderDuplicateFilesReport.new
    
    reporter.print_report(duplicates_files(files_group_by_hash))
  end

  private

  attr_reader :root_path, :data_path

  def files_group_by_hash
    arr = files.each_with_object(Hash.new([])) do |value, hash| 
      hash[file_hash(value)]+= [File.basename(value)] 
    end
  end

  def duplicates_files(hash)
    hash.select{|key, value| value.count > 1}
  end

  def file_hash(file_path)
    Digest::SHA256.file(file_path).to_s
  end

  def files
    @files ||= Dir.glob("#{data_path}**/**") 
  end
end
