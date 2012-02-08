#todo: move to own file
class Hash
  def reverse_merge(other_hash)
    other_hash.merge(self)
  end
  def reverse_merge!(other_hash)
    # right wins if there is no left
    merge!( other_hash ){|key,left,right| left }
  end
  def options_merge(options)
    self.to_options.reverse_merge options
  end
  def options_merge!(options)
    self.to_options!.reverse_merge! options
  end
end