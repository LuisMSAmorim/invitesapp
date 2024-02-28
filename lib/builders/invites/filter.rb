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

      def with_name(name)
        return self if name.blank?
        sanitized_query = ActiveRecord::Base.send(:sanitize_sql_array, ["companies.name ILIKE ?", "%#{name}%"])
        @filters.push([:where, sanitized_query])
        self
      end

      def with_inactivation_date(custom_date)
        return self if custom_date.blank?
        sanitized_query = ActiveRecord::Base.send(:sanitize_sql_array, ["invites.inactivated_at >= ?", custom_date])
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
