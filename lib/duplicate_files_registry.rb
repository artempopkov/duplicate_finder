class DuplicateFilesRegistry
  def initialize(digester, data_path)
    @digester = digester
    @files = Dir.glob("#{data_path}**/**")
    @duplicate_files = Hash.new { [] }
    add_files(@files)
  end

  def each
    duplicate_files.each_value { |duplicates| yield duplicates }
  end
  
  def empty?
    duplicate_files.empty?
  end
  
  def count_files
    files.count
  end
  
  def count_duplicates
    duplicate_files.count
  end

  def add_files(files_paths)
    files_paths.each { |file_path| add_file(file_path) }
  end

  def add_file(file_path)
    files << file_path unless files.include?(file_path)
    unless duplicate_files.values.include?(file_path)
      duplicate_files[digester.digest(file_path)] <<= File.basename(file_path)
    end
  end
  
  private
  
  attr_reader :digester, :files, :duplicate_files
end
