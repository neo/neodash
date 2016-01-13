class CuteAnimalsJob < Dashing::Job

  protected

  def do_execute
    image = config[:images].shuffle.first
    p image
    { image_url: image }
  end

end

