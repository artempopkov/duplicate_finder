require_relative '../lib/sha256_file_digester'
require 'tempfile'

describe Sha256FileDigester do
  context 'with file given' do
    let(:digest) { "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" }
    it 'gets file digest' do
      expect(subject.digest(Tempfile.create.path)).to eq digest
    end
  end

  context 'without file given' do
    it 'exits with error' do
      expect{ subject.digest('dfre') }.to raise_error(StandardError)
    end
  end
end
