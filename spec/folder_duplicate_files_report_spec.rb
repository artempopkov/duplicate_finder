require_relative '../lib/sha256_file_digester'
require_relative '../lib/duplicate_files_registry'
require_relative '../lib/folder_duplicate_files_report'

require 'rspec'
require 'colorize'

describe FolderDuplicateFilesReport do
  let(:registry) { DuplicateFilesRegistry.new(Sha256FileDigester.new, File::NULL) }
  let(:report) { FolderDuplicateFilesReport.new(registry) }

  context 'with one duplicate pair' do
    let(:expected_output) do
      [
        'There are duplicates'.green,
        '- 1.png, 2.png'.cyan,
        ''
      ].join("\n")
    end

    before { allow(registry).to receive(:duplicate_files).and_return({ a: %w[1.png 2.png] }) }

    it 'prints report' do
      expect { report.print }.to output(expected_output).to_stdout
    end
  end

  context 'with two duplicate pair' do
    let(:expected_output) do
      [
        'There are duplicates'.green,
        '- 1.png, 2.png'.cyan,
        '- 3.png'.cyan,
        ''
      ].join("\n")
    end

    before { allow(registry).to receive(:duplicate_files).and_return({ a: %w[1.png 2.png], b: ['3.png']}) }

    it 'prints report' do
      expect { report.print }.to output(expected_output).to_stdout
    end
  end
end
