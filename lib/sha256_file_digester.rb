require 'digest'

class Sha256FileDigester
  def digest(file_path)
    Digest::SHA256.file(file_path).to_s
  end
end
