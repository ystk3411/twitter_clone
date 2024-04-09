# frozen_string_literal: true

module DeviseHelper
  # deviseのフラッシュメッセージにbootstrapを適応
  def bootstrap_alert(key)
    case key
    when 'alert'
      'warning'
    when 'notice'
      'success'
    when 'error'
      'danger'
    end
  end
end
