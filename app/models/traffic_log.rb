class TrafficLog < ActiveRecord::Base

  def self.count_by_date(options = {})
      column = options[:column] || "created_at"
      max_date = (options[:max_date] || Time.zone.now).midnight
      num_days = options[:num_days] || 20
      min_date = (options[:min_date] || max_date.advance(:days => -(num_days-1))).midnight

      # if the db can't do (named) timezones, we do the best we can (dates on the
      # other side of dst will be wrong though)
      offset = max_date.utc_offset

      expression = case connection.adapter_name
      when 'MySQL', 'Mysql2'
        # TODO: detect mysql named timezone support and use it
        offset = "%s%02d:%02d" % [offset < 0 ? "-" : "+", offset.abs / 3600, offset.abs % 3600]
        "DATE(CONVERT_TZ(#{column}, '+00:00', '#{offset}'))"
      when /sqlite/
        "DATE(STRFTIME('%s', #{column}) + #{offset}, 'unixepoch')"
      when 'PostgreSQL'
        "((#{column} || '-00')::TIMESTAMPTZ AT TIME ZONE '#{Time.zone.tzinfo.name}')::DATE"
      end
      puts expression
      result = count(
        :conditions => [
          "#{column} >= ? AND #{column} < ?",
          min_date,
          max_date.advance(:days => 1)
        ],
        :group => expression,
        :order => expression
      )
      # mysql gives us date keys, sqlite/postgres don't 
      return result if result.keys.first.is_a?(Date)
      Hash[result.map { |date, count|
        [Time.zone.parse(date).to_date, count]
      }]
    end


end
