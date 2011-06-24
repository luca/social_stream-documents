class VideosController < InheritedResources::Base
  load_and_authorize_resource
  
  def show
    path = @video.file.path(params[:style])
    if(params[:style].present?)
      path = path.split('.')[0]+'.'+params[:style]
    end
    respond_to do |format|
      format.all {send_file path, 
                  :type => @video.file_content_type,
                  :disposition => "inline"}
    end
  end
  
  def index
    @document_activities = current_subject.wall(:profile,
                                        :for => current_subject,
                                        :object_type => :Video).all;
  end
  
end