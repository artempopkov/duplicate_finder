require_relative '../lib/sha256_file_digester'
require_relative '../lib/duplicate_files_registry'
require_relative '../lib/folder_duplicate_files_report'

require 'rspec'
require 'colorize'

describe FolderDuplicateFilesReport do
  before(:all) do
    @registry = DuplicateFilesRegistry.new(Sha256FileDigester.new, File::NULL)
  end

  let(:report) { FolderDuplicateFilesReport.new(@registry) }

  it 'prints report with one duplication pair' do
    allow(@registry).to receive(:duplicate_files).and_return({a: ['1.png', '2.png']})
    expected = "\e[0;32;49mThere are duplicates\e[0m\n\e[0;36;49m- 1.png, 2.png\e[0m\n"
    expect { report.print }.to output(expected).to_stdout
  end

  it 'prints report with one duplication pair' do
    allow(@registry).to receive(:duplicate_files).and_return({a: ['1.png', '2.png'], b: ['3.png']})
    expected = "\e[0;32;49mThere are duplicates\e[0m\n\e[0;36;49m- 1.png, 2.png\e[0m\n\e[0;36;49m- 3.png\e[0m\n"
    expect { report.print }.to output(expected).to_stdout
  end

end
