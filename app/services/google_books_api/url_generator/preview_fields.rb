module GoogleBooksApi
  module UrlGenerator
    module PreviewFields
      def items_fields
        "id,searchInfo/textSnippet,volumeInfo(#{volume_info_fields})"
      end

      def volume_info_fields_to_remove
        %w(description pageCount averageRating ratingsCount)
      end

      def volume_info_fields
        (Base::VOLUME_INFO_FIELDS - volume_info_fields_to_remove).join(',')
      end
    end
  end
end
