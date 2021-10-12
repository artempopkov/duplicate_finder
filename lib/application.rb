require 'digest'
require 'printer'

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

    Printer.print_hash_values(duplicates_files, message: are_there_duplicates(duplicates_files))
  end

  private

  attr_reader :root_path, :data_path

  def are_there_duplicates(hash)
    if hash.empty?
      'There aren\'t duplicate files'
    else
      'There are duplicate files'
    end
  end

  def files_hash_array
    files.each_with_object(Array.new) do |value, array|
      array << [file_hash(value), File.basename(value)]
    end
  end

  def file_hash(file_path)
    Digest::SHA256.file(file_path).to_s
  end

  def files
    @files ||= Dir.glob("#{data_path}**/**") 
  end

  def duplicates_files
    @duplicates_files ||= files_hash_array.group_by { |value| value.shift}.transform_values{ |value| value.flatten }.select{|key, value| value.count > 1}
  end
end
