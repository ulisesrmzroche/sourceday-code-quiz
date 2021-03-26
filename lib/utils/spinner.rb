# frozen_string_literal: true

# Spinner Module adds methods to make a progress indicator.
module Spinner
  # Prints a text-based "spinner" element while work occurs.
  def spinner_indicator(time)
    1.upto(time) do |_i|
      printf("\r %s", _spinner.next)
      sleep(0.1)
    end
  end

  private

  def _spinner
    Enumerator.new do |enum|
      _spin enum
    end
  end

  # NOTE: :reek:FeatureEnvy => Because it's just printing, it doesnt break the rule
  def _spin(enum)
    loop do
      enum.yield '|'
      enum.yield '/'
      enum.yield '-'
      enum.yield '\\'
    end
  end
end
