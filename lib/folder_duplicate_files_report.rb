class FolderDuplicateFilesReport
  def print_report(hash)
    puts hash.empty? ? "There are no duplicates" : "There are duplicates"
    
    hash.each_with_index do |value, index|
      puts index + 1
      puts "\t#{value[1].join(', ')}"
    end
  end
end