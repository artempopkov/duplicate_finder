class FolderDuplicateFilesReport
  def initialize(registry)
    @registry = registry
  end

  def print
    puts registry.empty? ? "There are no duplicates" : "There are duplicates"

    registry.each_duplicates_group { |duplicates| puts duplicates } 
  end

  private

  attr_reader :registry
end
