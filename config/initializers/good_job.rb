Rails.application.configure do
  config.good_job = {
    cleanup_preserved_jobs_before_seconds_ago: 1.day,
    preserve_job_records: true,
    on_thread_error: ->(exception) { Rails.error.report(exception, handled: true) },
    execution_mode: :async,
    queues: '*',
    max_threads: 5,
    poll_interval: 30,
    shutdown_timeout: 25,
    dashboard_default_locale: :en
  }
end
