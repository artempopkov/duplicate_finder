require 'colorize'
require 'folder_duplicate_files_report'
require 'sha256_file_digester'
require 'duplicate_files_registry'

class Application
  def initialize(root_path)
    @root_path = root_path
    @data_path = File.expand_path('data', root_path)
    @digester = Sha256FileDigester.new
    @registry = DuplicateFilesRegistry.new(@digester, data_path)
  end

  def self.start(root_path)
    new(root_path).start
  end

  def start
    abort 'There are no file available in data folder'.colorize(:red) if registry.empty?
    
    report = FolderDuplicateFilesReport.new(registry)
    report.print
  end

  private

  attr_reader :root_path, :data_path, :registry
end
