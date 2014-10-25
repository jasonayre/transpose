require "transpose/version"
#overkill?, maybe. But including primarily due to the
#dependency management portion of concerns, i.e.
#when manually defining extended method old fashioned way,
#things have potential for getting fubar,
#if you try to include Transposable into a concern

require "active_support/all"
require 'transpose/errors'
require 'transpose/transposable'

module Transpose

end
