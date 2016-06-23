json.array!(@questions) do |question|
  json.extract! question, :id, :title, :content, :category, :language
  json.url question_url(question, format: :json)
end
