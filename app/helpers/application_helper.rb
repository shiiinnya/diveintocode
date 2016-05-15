module ApplicationHelper

def profile_img(user)

  if user.image.present?
     img_url = user.image
  elsif
   user.provider == 'facebook'
    img_url = "https://graph.facebook.com/#{user.uid}/picture?width=70&height=40"
  elsif
   user.provider == 'twitter'
     img_url = "http://furyu.nazo.cc/twicon/#{user.name}/bigger"
  else
   gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    img_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
  image_tag(img_url, alt: user.name)
end


end
