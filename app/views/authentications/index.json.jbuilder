json.array!(@authentications) do |authentication|
  json.extract! authentication, :id, :uid, :nickname, :name
  json.url authentication_url(authentication, format: :json)
end
