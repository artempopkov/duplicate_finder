class DuplicateFilesRegistry
  def initialize(digester, files)
    @files_digestes = Hash.new([])
    @digester = digester
    add_files(files)
  end

  def each_duplicates_group
    duplicates_files.each_with_index do |duplicates, index|
      yield "#{index + 1}: #{duplicates[1].join(', ')}"
    end
  end
  
  def empty?
    duplicates_files.empty?
  end
  
  private
  
  attr_reader :files_digestes, :digester
  
  def add_files(files)
    files.each do |file_path|
      files_digestes[digester.digest(file_path)]+= [File.basename(file_path)]
    end
  end

  def duplicates_files
    files_digestes.select{|digest, files| files.count > 1}
  end
end
