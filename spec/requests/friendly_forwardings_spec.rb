require 'spec_helper'

describe "FriendlyForwardings" do
  
  it "should forward to the requested page after login" do
    user = Factory(:user)
    visit edit_user_path(user)
    # The test automatically follows the redirect to the login page.
    integration_log_in(user)
    # The test follows the redirect again, this time to users/edit
    response.should render_template('users/edit')
  end
end
