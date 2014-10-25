require 'spec_helper'
require 'support/remote_post'
require 'support/post'

describe ::Transpose::Transposable do
  let(:id_value) { "1234" }
  let(:title_value) { "Nocturne In e Flat Op 9 No.2"}
  subject { ::RemotePost.new(:Id => id_value, :Title => title_value) }

  describe "#transpose" do
    context "RemotePost to Post" do
      let(:transposition) { subject.transpose_to(::Post) }

      it { transposition.id.should eq id_value }
      it { transposition.title.should eq title_value }
      it { transposition.should be_a(Post) }

      context "Back to remote post" do
        let(:retransposition) { transposition.transpose_to(::RemotePost) }

        it { retransposition.Id.should eq id_value }
        it { retransposition.Title.should eq title_value }
        it { retransposition.should be_a(RemotePost) }
      end
    end

    context "transposer does not exist" do
      it "raises error" do
        expect{ subject.transpose_to(Hash) }.to raise_error(Transpose::Errors::TransposerNotFound)
      end
    end
  end

  describe "#transpose_instance" do
    let(:post) { ::Post.new(:category => 'cat1234') }
    let(:transposition) { subject.transpose_instance(post) }

    context "RemotePost to post" do
      it { transposition.id.should eq id_value }
      it { transposition.category.should eq 'cat1234' }
    end
  end

  describe ".transposer" do
    before do
      subject.class.transposer "OpenStruct", {
        :Id => :id,
        :Title => :title
      }
    end

    it { subject.class.transposers.should have_key("OpenStruct") }
  end
end
