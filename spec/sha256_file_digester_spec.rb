require_relative '../lib/sha256_file_digester'
require 'rspec'
require 'tempfile'

describe Sha256FileDigester do
  it 'should get file digest' do
    expected = subject.digest(Tempfile.create.path)
    expect(expected).to eq "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  end
end
