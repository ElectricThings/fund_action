# frozen_string_literal: true

class AirbrakeFilter

  IGNORED_DJ_EXCEPTIONS = [
    'Delayed::WorkerTimeout',
  ]

  def call(notice)
    return unless errors = notice[:errors]

    if ctx = notice[:context] and ctx[:component] == 'delayed_job'
      # error from delayed job

      # errors may be more than one with nested exceptions, if one of them is
      # of an ignored type, we ignore the whole notification
      if errors.any? { |error|
           IGNORED_DJ_EXCEPTIONS.include? error[:type]
         }

        notice.ignore!
      end

    else # any other error

      if errors.any? { |error| ignore_error?(error) }
        notice.ignore!
      end
    end
  end

  private

  def ignore_error?(error)
    # Some errors are handled by Rails itself in a later stage than the
    # Airbrake middleware, e.g. through proper status codes.
    return true if ActionDispatch::ExceptionWrapper.rescue_responses[error[:type]] != :internal_server_error

    # Ignore SIGTERM errors - these are thrown by Puma on shutdown. Purpose is
    # to tell other code to do their cleanup work.
    return true if error[:type] == 'SignalException' && error[:message] == 'SIGTERM'
  end

end

