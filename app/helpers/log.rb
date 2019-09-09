class Log

  def self.i(message)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.info "#{log_tag}: #{message}"
  end

  def self.info_with_exception(message, exception)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.info "#{log_tag}: #{message}\n" \
      + Log.get_exception_log(exception)
  end

  def self.d(message)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.debug "#{log_tag}: #{message}"
  end

  def self.debug_with_exception(message, exception)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.debug "#{log_tag}: #{message}\n" \
      + Log.get_exception_log(exception)
  end

  def self.w(message)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.warn "#{log_tag}: #{message}"
  end

  def self.warn_with_exception(message, exception)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.warn "#{log_tag}: #{message}\n" \
      + Log.get_exception_log(exception)
  end

  def self.e(message)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.error "#{log_tag}: #{message}"
  end

  def self.error_with_exception(message, exception)
    log_tag = Log.get_log_tag(caller[0])
    Rails.logger.error "#{log_tag}: #{message}\n" \
      + Log.get_exception_log(exception)
  end

  def self.log_source_caller
    Log.i "source_caller_stack_#{caller[0..9].map{ |str| Log.get_log_tag(str) }}"
  end

  private

  def self.get_log_tag(dir_file_line_method_string)
    file_line_method_string = dir_file_line_method_string.split('/').last
    file_line_method = file_line_method_string.split(":")
    file = file_line_method[0]
    line = file_line_method[1]
    method = file_line_method[2].gsub(/in |'|`/, "")
    return "#{file}:#{method}:#{line}"
  end

  def self.get_exception_log(exception)
    return exception.message + "\n" + exception.backtrace.join("\n")
  end
end
