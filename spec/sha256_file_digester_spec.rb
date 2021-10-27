require_relative '../lib/sha256_file_digester'
require 'rspec'

describe Sha256FileDigester do
  let (:digester) { Sha256FileDigester.new }
  let (:file_path) { File.expand_path('data/0.png', __dir__) }

  it 'should get file digest' do
    digest = digester.digest(file_path)
    expect(digest).to eq "55aaed6639332a1c18c6029bb60f58eac2703281b7b3882e05b4042982c81e4c"
  end
end
