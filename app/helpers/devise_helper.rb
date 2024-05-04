# frozen_string_literal: true

module DeviseHelper
  # deviseのフラッシュメッセージにbootstrapを適応
  KEYS = {
    'alert' => 'warning',
    'notice' => 'success',
    'error' => 'danger'
  }.freeze
  def bootstrap_alert(key)
    KEYS[key]
  end
end
