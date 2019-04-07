require 'json'
RSpec.describe NicoSnapshotApi do
  it "has a version number" do
    expect(NicoSnapshotApi::VERSION).not_to be nil
  end

  it "does something useful" do
    api = NicoSnapshotApi::Client.new
    res = api.search_keyword("幕末志士")
    expect(res).to eq("test")
  end
end
