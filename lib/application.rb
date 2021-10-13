require 'digest'
require 'folder_duplicate_files_report'
require 'folder_files_hasher'

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
    hasher = FolderFileHasher.new
    reporter.print_report(duplicates_files(hasher.files_group_by_hash(files)))
  end

  private

  attr_reader :root_path, :data_path

  def duplicates_files(hash)
    hash.select{|key, value| value.count > 1}
  end

  def files
    @files ||= Dir.glob("#{data_path}**/**") 
  end
end
