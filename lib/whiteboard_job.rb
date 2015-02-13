require 'redcarpet'
require 'rest_client'

class WhiteboardJob < Dashing::Job

  protected

  def do_execute
    response = RestClient.get config[:interestings_url]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    html_content = markdown.render response
    { content: html_content }
  end

end

