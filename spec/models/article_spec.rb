require 'spec_helper'
require "rails_helper"

RSpec.describe Article, :type => :model do
  it "is valid with valid attributes" do
    expect(Article.new(title: "Test Article", body: "Test article body", status: "public")).to be_valid
  end
  
  it "is not valid without a title" do
    expect(Article.new(body: "Test article body", status: "public")).to_not be_valid
  end

  it "is not valid without a body" do
    expect(Article.new(title: "Test Article", status: "public")).to_not be_valid
  end

  it "is not valid without a status" do
    expect(Article.new(title: "Test Article", body: "Test article body")).to_not be_valid
  end
end
