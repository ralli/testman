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

  def result_label(result)
    t("helpers.result.#{result}")
  end

  def status_label(status)
    t("helpers.status.#{status}")
  end

  def result_chart_series(series)
    (series.collect { |x| [result_label(x[0]), x[1] ] }).to_json
  end

  def status_chart_series(series)
    (series.collect { |x| [status_label(x[0]), x[1] ] }).to_json
  end
end

