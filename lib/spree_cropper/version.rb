module SpreeCropper
  module_function

  # Returns the version of the currently loaded SpreeCropper as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 2
    TINY  = 6
    PRE   = 'beta'.freeze

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
