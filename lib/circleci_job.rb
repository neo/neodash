require 'circleci'

class CircleciJob < Dashing::Job
  protected

  def do_execute
    config_file = File.dirname(File.expand_path(__FILE__)) + '/../config/circleci.yml'
    config = YAML::load(File.open(config_file))

    CircleCi.configure { |c| c.token = config['auth_token'] }
    config['projects'].each do |data_id, options|
      res = CircleCi::Project.recent_builds options['user'], options['repo']
      body = res.body.is_a?(Array) ? res.body : []

      send_event(data_id, get_build_info(body)) rescue nil
    end
  end

  def get_build_info(builds=[])
    builds = builds.first(5).map do |build|
      result = {
        state:         build['status'],
        success:       (build['outcome'] == 'success'),
        duration:      build['build_time_millis'],
        change_author: build['author_email'],
        timestamp:     Time.parse(build['stop_time'] || build['start_time']).to_i
      }

      result
    end

    timestamp = builds.empty? ? nil : builds[0][:timestamp]
    { builds: builds, timestamp: timestamp }
  end
end
