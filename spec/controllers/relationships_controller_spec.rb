require 'spec_helper'

describe RelationshipsController do
  
  describe "access controll" do
    
    it "should require login for create" do
      post :create
      response.should redirect_to(login_path)
    end
    
    it "should require login for destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(login_path)
    end
  end
  
  describe "POST 'create'" do
  
    before(:each) do
      @user = test_log_in(Factory(:user))
      @followed = Factory(:user, :email => Factory.next(:email))
    end
  
    it "should create a relationship" do
      lambda do
        post :create, :relationship => { :followed_id => @followed }
        response.should be_redirect
      end.should change(Relationship, :count).by(1)
    end
    
    it "should create a relationship using Ajax" do
      lambda do
        xhr :post, :create, :relationship => { :followed_id => @followed }
        response.should be_success
      end.should change(Relationship, :count).by(1)
    end
  end
  
  describe "delete 'destroy'" do
    
    before(:each) do
       @user = test_log_in(Factory(:user))
       @followed = Factory(:user, :email => Factory.next(:email))
       @user.follow!(@followed)
       @relationship = @user.relationships.find_by_followed_id(@followed)
    end
  
  
    it "should destroy a relationship" do
      lambda do
        delete :destroy, :id => @relationship
        response.should be_redirect
      end.should change(Relationship, :count).by(-1)
    end
    
    it "should destroy a relationship using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @relationship
        response.should be_success
      end.should change(Relationship, :count).by(-1)
    end 
  end
end