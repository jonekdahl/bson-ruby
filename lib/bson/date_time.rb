# Copyright (C) 2009-2013 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module BSON

  # Injects behaviour for encoding date time values to raw bytes as specified by
  # the BSON spec for time.
  #
  # @see http://bsonspec.org/#/specification
  #
  # @since 2.1.0
  module DateTime

    # Get the date time as encoded BSON.
    #
    # @example Get the date time as encoded BSON.
    #   DateTime.new(2012, 1, 1, 0, 0, 0).to_bson
    #
    # @return [ String ] The encoded string.
    #
    # @see http://bsonspec.org/#/specification
    #
    # @since 2.1.0
    def to_bson(encoded = ''.force_encoding(BINARY))
      to_time.to_bson(encoded)
    end

    if Environment.ree?

      # Constant to multiple the seconds fraction my for millis in REE.
      #
      # @since 2.1.0
      FACTOR = 86400000000

      # REE does not define a to_time on DateTime, so if we are using REE we
      # define it ourselves.
      #
      # @example Conver the DateTime to a time.
      #   date_time.to_time
      #
      # @return [ Time ] The converted time.
      #
      # @since 2.1.0
      def to_time
        ::Time.utc(year, mon, mday, hour, min, sec, (sec_fraction * FACTOR).to_i).getlocal
      end
    end
  end

  # Enrich the core DateTime class with this module.
  #
  # @since 2.1.0
  ::DateTime.send(:include, DateTime)
end