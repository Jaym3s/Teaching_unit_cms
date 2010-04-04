require 'spec_helper'

describe SenseiController do

  context "index" do
    before do
      get 'index'
    end
    it "responds to index" do
      response.should be_success
    end
  end

end
