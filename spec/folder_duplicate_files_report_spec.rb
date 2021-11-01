require_relative '../lib/sha256_file_digester'
require_relative '../lib/duplicate_files_registry'
require_relative '../lib/folder_duplicate_files_report'

require 'rspec'
require 'colorize'

describe FolderDuplicateFilesReport do
  before(:all) do
    @data_path = File.expand_path('data', __dir__)
    @registry = DuplicateFilesRegistry.new(Sha256FileDigester.new, @data_path)
  end

  let(:report) { FolderDuplicateFilesReport.new(@registry) }

  it 'should print report to console' do
    expected = "\e[0;32;49mThere are duplicates\e[0m\n\e[0;36;49m- 13.png, 14.png\e[0m\n"
    expect { report.print }.to output(expected).to_stdout
  end
end
