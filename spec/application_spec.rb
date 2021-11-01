require_relative '../lib/application'
require 'rspec'
require 'colorize'

describe Application do
  let(:app) { Application.new(File::NULL) }

  context 'when there are files in data folder' do
    it 'starts duplicate finder and produce report' do
      registry = instance_double(DuplicateFilesRegistry)
      allow(registry).to receive(:empty?).and_return(false)
      allow(DuplicateFilesRegistry).to receive(:new).and_return(registry)

      report = instance_double(FolderDuplicateFilesReport)
      allow(report).to receive(:print).and_return('Print works!')
      allow(FolderDuplicateFilesReport).to receive(:new).and_return(report)

      expect(app.start).to eq "Print works!"
    end
  end

  context 'when there are not files in data folder' do
    it 'starts duplicate finder and abort with message' do
      allow(app).to receive(:registry).and_return([])
      error_message = 'There are no file available in data folder'.colorize(:red)
      expect { app.start }.to raise_error(SystemExit, error_message)
    end
  end
end
