require "rails_helper"

describe PetfinderIntegration::Connection, :focus => true do
  subject { PetfinderIntegration::Connection }


  it '.get should add keys and format and execute connection with endpoint, api_method and params' do
    conn = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.get('') { |env| [ 200, {}, { 'test' => 'success' }.to_json ]}
      end
    end

    expect(subject).to receive(:exec).with('http://api.petfinder.com', 'shelter.get', {
                                             'format' => 'json', 'key' => '3ea4a92e053a83bda1d17959baf8b158', 'id' => 'NY803' }).and_return(conn)

    result = subject.get('shelter.get', { 'id' => 'NY803' })
    expect(result['test']).to eq 'success'
  end
end
