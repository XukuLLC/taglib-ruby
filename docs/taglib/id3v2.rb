module TagLib::ID3v2
  # An ID3v2 tag.
  class Tag < TagLib::Tag
    # Get a list of frames. Note that the frames returned are subclasses
    # of {TagLib::ID3v2::Frame}, depending on the frame ID.
    #
    # @overload frame_list()
    #   Returns all frames.
    #
    # @overload frame_list(frame_id)
    #   Returns frames matching ID.
    #
    #   @param [String] frame_id Specify this parameter to get only the
    #     frames matching a frame ID (e.g. "TIT2").
    #
    # @return [Array<TagLib::ID3v2::Frame>]
    def frame_list
    end

    # Add a frame to the tag.
    #
    # @param [Frame] frame
    # @return [void]
    def add_frame(frame)
    end

    # Remove the passed frame from the tag.
    #
    # **Note:** You can and shall not call any methods on the frame
    # object after you have passed it to this method, because the
    # underlying C++ object has been deleted.
    #
    # @param [Frame] frame to remove
    # @return [void]
    def remove_frame(frame)
    end

    # Remove all frames with the specified ID from the tag.
    #
    # **Note:** If you have obtained any frame objects with the same ID
    # from the tag before calling this method, you should not touch them
    # anymore. The reason is that the C++ objects may have been deleted.
    #
    # @param [String] id
    # @return [void]
    def remove_frames(id)
    end
  end

  # The base class for all ID3v2 frames.
  #
  # In ID3v2 all frames are identified by a {#frame_id frame ID}, such
  # as `TIT2` or `APIC`. The data in the frames is different depending
  # on the frame type, which is why there is a subclass for each type.
  #
  # The most common frame type is the text identification frame. All
  # frame IDs of this type begin with `T`, for example `TALB` for the
  # album. See {TextIdentificationFrame}.
  #
  # Then there are the URL link frames, which begin with `W`, see
  # {UrlLinkFrame}.
  #
  # Finally, there are some specialized frame types and their
  # corresponding classes:
  #
  # * `APIC`: {AttachedPictureFrame}
  # * `COMM`: {CommentsFrame}
  # * `GEOB`: {GeneralEncapsulatedObjectFrame}
  # * `POPM`: {PopularimeterFrame}
  # * `PRIV`: {PrivateFrame}
  # * `RVAD`: {RelativeVolumeFrame}
  # * `TXXX`: {UserTextIdentificationFrame}
  # * `UFID`: {UniqueFileIdentifierFrame}
  # * `USLT`: {UnsynchronizedLyricsFrame}
  # * `WXXX`: {UserUrlLinkFrame}
  #
  class Frame
    # @return [String] frame ID
    attr_reader :frame_id

    # @return [String] a subclass-specific string representation
    def to_string
    end
  end

  # Attached picture frame (APIC), e.g. for cover art.
  #
  # The constants in this class are used for the {#type} attribute.
  class AttachedPictureFrame < Frame
    # Other
    Other              = 0x00
    # 32x32 file icon (PNG only)
    FileIcon           = 0x01
    OtherFileIcon      = 0x02
    FrontCover         = 0x03
    BackCover          = 0x04
    LeafletPage        = 0x05
    Media              = 0x06
    LeadArtist         = 0x07
    Artist             = 0x08
    Conductor          = 0x09
    Band               = 0x0A
    Composer           = 0x0B
    Lyricist           = 0x0C
    RecordingLocation  = 0x0D
    DuringRecording    = 0x0E
    DuringPerformance  = 0x0F
    MovieScreenCapture = 0x10
    ColouredFish       = 0x11
    Illustration       = 0x12
    BandLogo           = 0x13
    PublisherLogo      = 0x14

    def initialize()
    end

    # @return [String]
    attr_accessor :description

    # MIME type (e.g. `"image/png"`)
    # @return [String]
    attr_accessor :mime_type

    # {include:GeneralEncapsulatedObjectFrame#object}
    #
    # @return [binary String]
    attr_accessor :picture

    # {include:TextIdentificationFrame#text_encoding}
    #
    # @return [TagLib::String constant]
    attr_accessor :text_encoding

    # Type of the attached picture, see constants.
    # @return [AttachedPictureFrame constant]
    attr_accessor :type
  end

  # Comments frame (COMM) for full text information that doesn't fit in
  # any other frame.
  class CommentsFrame < Frame
    # @return [String] content description, which together with language
    #   should be unique per tag
    attr_accessor :description

    # @return [String] alpha-3 language code of text (ISO-639-2),
    #   e.g. "eng"
    attr_accessor :language

    # @return [String] the actual comment text
    attr_accessor :text

    # {include:TextIdentificationFrame#text_encoding}
    #
    # @return [TagLib::String constant]
    attr_accessor :text_encoding
  end

  # General encapsulated object frame (GEOB).
  class GeneralEncapsulatedObjectFrame < Frame
    # @return [String] content description
    attr_accessor :description

    # @return [String] file name
    attr_accessor :file_name

    # @return [String] MIME type
    attr_accessor :mime_type

    # Binary data string.
    #
    # Be sure to use a binary string when setting this attribute. In
    # Ruby 1.9, this means reading from a file with `"b"` mode to get a
    # string with encoding `BINARY` / `ASCII-8BIT`.
    #
    # @return [binary String]
    attr_accessor :object

    # {include:TextIdentificationFrame#text_encoding}
    #
    # @return [String]
    attr_accessor :text_encoding
  end

  # Popularimeter frame (POPM).
  class PopularimeterFrame < Frame
    # @return [Integer] play counter
    attr_accessor :counter

    # @return [String] e-mail address
    attr_accessor :email

    # @return [Integer] rating
    attr_accessor :rating
  end

  # Private frame (PRIV).
  class PrivateFrame < Frame
    # {include:GeneralEncapsulatedObjectFrame#object}
    #
    # @return [binary String]
    attr_accessor :data

    # @return [String] owner identifier
    attr_accessor :owner
  end

  class RelativeVolumeFrame < Frame
  end

  class TextIdentificationFrame < Frame
    # Encoding for storing the text in the tag, e.g.
    # `TagLib::String::UTF8`. See the section _String Encodings_ in
    # {TagLib}.
    #
    # @return [TagLib::String constant]
    attr_accessor :text_encoding
  end

  class UserTextIdentificationFrame < TextIdentificationFrame
  end

  class UniqueFileIdentifierFrame < Frame
  end

  class UnsynchronizedLyricsFrame < Frame
  end

  class UrlLinkFrame < Frame
  end

  class UserUrlLinkFrame < UrlLinkFrame
  end
end