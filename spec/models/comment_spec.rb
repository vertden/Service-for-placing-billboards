require 'rails_helper'

RSpec.describe Comment do
  context "validation tests" do
    it "ensures body is present" do
      comment = Comment.new(billboard_id: 1)
      expect(comment.valid?).to eq(false)
    end

    it "ensures billboard_id is present" do
      comment = Comment.new(body: "Some text")
      expect(comment.valid?).to eq(false)
    end
    it "should be able to save comment" do
      comment = Comment.new(body: "Some text",billboard_id: 1)
      expect(comment.save).to eq(true)
    end
  end
end













