class JenkinsStatus < Dashing::Job

  protected

  def do_execute
    build_status
  end

  private

  def load_project(url, project)
    client = Jenkins::Client.new(url)
    client.load_project(project)
  end

  def build_status
    project = load_project(config[:url], config[:project])

    status = {}
    status[:logo] = '/assets/jenkins.png'
    status[:score] = project.health_score

    status[:builds] = project.last_builds.first(5).map do |build|
      buildInfo = {
        id:        build.url,
        success:   build.success?,
        ongoing:   build.building?,
        timestamp: build.timestamp,
        duration:  build.duration,
      }

      if cs = build.changesets.first
        buildInfo[:author] = cs.author
        buildInfo[:comment] = cs.comment
      end

      buildInfo
    end

    status
  end
end
