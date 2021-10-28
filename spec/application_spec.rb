require_relative '../lib/application'
require 'rspec'
require 'o_stream_catcher'

describe Application do
  let(:data_path) { File.expand_path('data', __dir__) }
  let(:app) { Application.new(__dir__) }

  context 'when there are files in data folder' do
    it 'it should start duplicate finder and produce report' do
      result, stdout, stderr = OStreamCatcher.catch do
        app.start
      end
      expect(stdout).to eq "\e[0;32;49mThere are duplicates\e[0m\n\e[0;36;49m- 13.png, 14.png\e[0m\n"
    end
  end

  context 'when there arent files in data folder' do
    before do
      File.delete("#{data_path}/13.png")
      File.delete("#{data_path}/14.png")
    end

    after do
      File.open("#{data_path}/13.png", 'w+')
      File.open("#{data_path}/14.png", 'w+')
    end

    it 'it should start duplicate finder and abort' do
      expect do
        result, stdout, stderr = OStreamCatcher.catch do
          app.start
        end
      end.to raise_error(SystemExit)    
    end
  end
end
