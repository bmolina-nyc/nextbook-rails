module GoogleBooksApi
  module UrlGenerator
    module PreviewFields
      FIELDS = Base::VOLUME_INFO_FIELDS

      def get_fields
        "totalItems,items(#{items_fields})"
      end

      def items_fields
        "id,searchInfo/textSnippet,volumeInfo(#{volume_info_fields})"
      end

      def volume_info_fields
        ([FIELDS] - ['description', 'page_count']).join(',')
      end
    end
  end
end
