module WelcomeHelper
  def as_number(val)
    (val || 0).to_s
  end

  def datetime_series_to_json(a)
    s = []
    a.each do |x|
      date = x[0]
      count = x[1]
      s << "[Date.UTC(#{date.year}, #{date.month-1}, #{date.mday}), #{count}]"
    end
    "[#{s.join(", ")}]"
  end
end

