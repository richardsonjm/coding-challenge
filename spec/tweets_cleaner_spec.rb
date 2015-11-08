require_relative './spec_helper.rb'

describe TweetsCleaner do
  before do
    allow(File).to receive(:read)
    allow(File).to receive(:open)
    @tweets_cleaner = TweetsCleaner.new('source', 'destination')
  end

  subject { @tweets_cleaner }

  describe "#clean_text" do
    it "should increment unicode counter if unicode" do
      pending
    end
  end

  describe "#remove_unicode" do
    it "should remove unicode characters from string" do
      string = "Thanks for noticing\u2014you really are magical."

      expect(subject.remove_unicode(string)).to eq "Thanks for noticingyou really are magical."
    end
  end

  describe "#remove_escape_characters" do
    # it "should replace \\/ with /" do
    #   string = "\/"
    #   expect(subject.remove_escape_characters(string)).to eq "/"
    # end

    # it "should replace \\\\ with \\" do
    #   string = "\\\\"
    #   expect(subject.remove_escape_characters(string)).to eq "\\"
    # end

    # it "should replace /' with '" do
    #   string = "Thanks for noticing/'you really are magical."
    #   expect(subject.remove_escape_characters(string)).to eq "Thanks for noticing'you really are magical."
    # end

    # it "should replace \\\" with \"" do
    #   string = "\\\""
    #   expect(subject.remove_escape_characters(string)).to eq "\""
    # end

    # it "should replace newline with space" do
    #   string = "Thanks for noticing\nyou really are magical."
    #   expect(subject.remove_escape_characters(string)).to eq "Thanks for noticing you really are magical."
    # end
  end
end
