require "rails_helper"

describe Pets do
  subject { Pets }

  describe "Default Schema" do
    expect(Pets).to have_index_for(:name)
  end
end
