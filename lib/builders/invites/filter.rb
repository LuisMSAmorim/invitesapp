module Builders
  module Invites
    class Filter
      def initialize(base_query)
        @base_query = base_query
        @filters = []
      end

      def with_company_id(company_id)
        @filters.push([:where, company_id: company_id]) if company_id.present?
        self
      end

      def with_title(title)
        return self if title.blank?
        sanitized_query = ActiveRecord::Base.send(:sanitize_sql_array, ["invites.title ILIKE ?", "%#{title}%"])
        @filters.push([:where, sanitized_query])
        self
      end

      def with_inactivation_date(custom_date)
        custom_date = Date.today if custom_date.blank?
        sanitized_query = ActiveRecord::Base.send(:sanitize_sql_array, ["invites.inactivated_at >= ? OR invites.inactivated_at IS NULL", custom_date])
        @filters.push([:where, sanitized_query])
        self
      end

      def call
        @filters.each do |filter|
          @base_query = @base_query.send(filter[0], filter[1])
        end
        @base_query
      end
    end
  end
end
