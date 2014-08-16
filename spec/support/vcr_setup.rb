VCR.configure do |c|

  c.allow_http_connections_when_no_cassette = false

  # c.debug_logger = $stdout
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.before :each, vcr_off: true do
    VCR.turn_off!(:ignore_cassettes => true)
    WebMock.allow_net_connect!
  end

  c.after :each, vcr_off: true do
    VCR.turn_on!
    WebMock.disable_net_connect!
  end
end
