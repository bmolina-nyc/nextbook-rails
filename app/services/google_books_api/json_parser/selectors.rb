module GoogleBooksApi
  module JsonParser
    module Selectors
      def get_google_id(item)
        item['id']
      end

      def get_title(item)
        item['volumeInfo']['title']
      end

      def get_subtitle(item)
        item['volumeInfo']['subtitle']
      end

      def get_authors(item)
        item['volumeInfo']['authors']
      end

      def get_published_date(item)
        item['volumeInfo']['publishedDate']
      end

      def get_description(item)
        item['volumeInfo']['description']
      end

      def get_thumbnail(item)
        volume_info = item['volumeInfo']
        volume_info.key?('imageLinks') ?
          volume_info['imageLinks']['thumbnail'] : nil
      end

      def get_page_count(item)
        item['volumeInfo']['pageCount']
      end

      def get_categories(item)
        item['volumeInfo']['categories']
      end

      def get_preview(item)
        item.key?('searchInfo') && item['searchInfo'].key?('textSnippet') ?
          item['searchInfo']['textSnippet'] : nil
      end

      def get_publisher(item)
        item['volumeInfo']['publisher']
      end
    end
  end
end
