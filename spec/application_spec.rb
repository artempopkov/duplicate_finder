require_relative '../lib/application'
require 'rspec'
require 'colorize'

describe Application do
  before(:each) do

  end
  let(:app) { Application.new(File::NULL) }

  context 'when there are files in data folder' do
    it 'starts duplicate finder and produce report' do
      
      expected = "\e[0;32;49mThere are duplicates\e[0m\n\e[0;36;49m- 13.png, 14.png\e[0m\n"
      expect { app.start }.to output(expected).to_stdout 
    end
  end

  # context 'when there are not files in data folder' do
  #   it 'starts duplicate finder and abort with message' do
  #     allow(app).to receive(:registry).and_return([])
  #     error_message = 'There are no file available in data folder'.colorize(:red)
  #     expect { app.start }.to raise_error(SystemExit, error_message)
  #   end
  # end
end
