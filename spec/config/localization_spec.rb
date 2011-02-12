require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "Localization" do
  class HashkeyList
	  attr_reader :keys

    def initialize(h)
      @keys = []
      nested_hash_keys(h)
      @keys.sort!
    end

    private
    def nested_hash_keys(h, a = [])
      h.each do |k,v|
        a.push k.to_s
        if v.instance_of? Hash
          nested_hash_keys(v, a)
        end
        @keys << a.join('.')
        a.pop
      end
    end
  end

  def nested_hash_keys(h)
    HashkeyList.new(h).keys
  end

  def load_yaml_file(filename)
    File.open(File.join(Rails.root, "config", "locales", filename)) do |f|
      YAML::load(f)
    end
  end

  describe "german translation" do
    it "should have the same set of keys as the english translation" do
      de_contents = load_yaml_file('de.yml')['de']
      en_contents = load_yaml_file('en.yml')['en']
      nested_hash_keys(en_contents).should== nested_hash_keys(de_contents)
    end
  end
end

