class FolderDuplicateFilesReport
  def initialize(registry)
    @registry = registry
  end

  def print
    if registry.empty?
      puts 'There are no duplicates'.colorize(:red)
    else
      puts 'There are duplicates'.colorize(:green)
      registry.each do |duplicates| 
        puts "- #{duplicates.join(', ')}".colorize(:blue)
      end 
    end
  end

  private

  attr_reader :registry
end
