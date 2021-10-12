class Printer
  def self.print_hash_values(hash, message: "Hash:")
    puts "#{message}"
    
    hash.each_with_index do |value, index|
      puts index + 1
      puts "\t#{value[1].join(', ')}"
    end
  end
end
