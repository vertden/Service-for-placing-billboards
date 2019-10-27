class Billboard < ApplicationRecord
  mount_uploader :photo, AvatarUploader
end
