class DuplicateFilesRegistry
  def initialize(digester, data_path)
    @digester = digester
    @files = Dir.glob("#{data_path}**/**")
    @duplicate_files = Hash.new([])
    add_files(@files)
  end

  def each
    duplicate_files.each_value { |duplicates| yield duplicates }
  end
  
  def empty?
    files.empty?
  end

  def add_files(files)
    files.each { |file_path| add_file(file_path) }
  end

  def add_file(file_path)
    duplicate_files[digester.digest(file_path)]+= [File.basename(file_path)]
  end
  
  private
  
  attr_reader :digester, :files, :duplicate_files
end
