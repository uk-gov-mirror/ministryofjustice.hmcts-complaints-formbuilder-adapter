class SentryJobArgumentScrubber < Raven::Processor
  def process(data)
    return data unless data[:extra][:delayed_job]

    data[:extra][:delayed_job] = STRING_MASK
    data[:extra][:active_job] = STRING_MASK
    data
  end
end
