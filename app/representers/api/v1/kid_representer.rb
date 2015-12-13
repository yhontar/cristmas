class API::V1::KidRepresenter < API::BaseRepresenter
  property :id
  property :name
  property :video, getter: lambda { |args| video.try(:url) }
  property :address
  property :status
  property :thumb, getter: lambda { |args| video.try(:thumb).try(:url) }
  property :feedback_video, getter: lambda { |args| feedback_video.try(:url) }
  property :feedback_video_thumb, getter: lambda { |args| feedback_video.try(:thumb).try(:url) }

  link :self do
    api_v1_kid_path represented
  end
end
