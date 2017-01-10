# The progress circle icon which can show progress one quarter at a time
class QuarterCircleCell < Cell::ViewModel
  include ::Cell::Haml
  def show
    progress_view = "p#{@options[:progress]}"
    render progress_view.to_sym
  end
end
