module ProfilesHelper
  def end_of_lease(employment)
    employment["start_date"] + employment["duration"].month
  end

  def get_avatar
    if @profile.avatar?
      @profile.avatar_url(:thumb)
    else
      "avatar.jpeg"
    end
  end

end
