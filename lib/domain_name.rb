class Domainname
  attr_accessor :id, :value, :word, :tld
  def initialize word, tld
    @word = word
    @tld = tld
    @value = yield(word, tld) if block_given?
  end
  def save!
    #noop
  end
  def to_s
    @value
  end
end