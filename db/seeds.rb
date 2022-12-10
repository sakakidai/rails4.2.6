file = File.read('db/seeds/articles.json')
json = ActiveSupport::JSON.decode(file)
json.each do |record|
  Article.create!(record)
end
