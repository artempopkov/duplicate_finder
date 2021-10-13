class FolderFileHasher
  def file_hash(file_path)
    Digest::SHA256.file(file_path).to_s
  end

  def files_group_by_hash(files)
    arr = files.each_with_object(Hash.new([])) do |value, hash| 
      hash[file_hash(value)]+= [File.basename(value)] 
    end
  end
end
