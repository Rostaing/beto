json.extract! contact, :id, :first_name, :last_name, :email, :topic, :web_site, :message, :created_at, :updated_at
json.url contact_url(contact, format: :json)
