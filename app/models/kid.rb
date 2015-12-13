class Kid < ActiveRecord::Base

  belongs_to :user
  belongs_to :volonter

  validates :name, :age, :description, :video, :address, presence: true

  scope :not_delivered,   -> ()   { where.not(status: 3) }
  scope :by_status, -> (status) { where(status: status) }

  enum status: [:free, :in_list, :pending_approval, :delivered] unless instance_methods.include? :status

  mount_uploader :video, VideoUploader
  mount_uploader :feedback_video, FeedbackVideoUploader

  def add_to_pending(id)
    self.update_columns(user_id: id, status: 1) unless self.user_id
  end

  def can_be_accepted?
    status == 0
  end

  def accept_sending
    self.update_columns(status: 2)
  end

  def remove_from_list
    self.update_columns(status: 0, user_id: nil)
  end

  def feedback_thumb
    self.try(:feedback_video).try(:thumb).try(:url)
  end

  def thumb
    self.try(:video).try(:thumb).try(:url)
  end

  def get_video_duration
    Time.at(video_duration.to_i).utc.strftime("%M:%S")
  end

  def get_class_kid
    if status == 1
      'card__panding'
    elsif status == 2
      'card__send'
    end
  end

  def delivered!(video)
    self.update_attributes(feedback_video: video, status: 3)
  end
end
