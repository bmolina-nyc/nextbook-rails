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

      def get_image_link(item)
        volume_info = item['volumeInfo']
        volume_info.key?('imageLinks') ? volume_info['imageLinks']['thumbnail'] : nil
      end

      def get_page_count(item)
        item['volumeInfo']['pageCount']
      end

      def get_ratings_count(item)
        item['volumeInfo']['ratingsCount']
      end

      def get_average_rating(item)
        item['volumeInfo']['averageRating']
      end

      def get_genres(item)
        item['volumeInfo']['categories']
      end

      def get_text_preview(item)
        begin
          item['searchInfo']['textSnippet']
        rescue
          nil
        else
          item['searchInfo']['textSnippet']
        end
      end
    end
  end
end
