class Article < ApplicationRecord
after_save :update_csv # The callback method is added here
private
def update_csv
  require "csv"
  CSV.open("articles.csv", "wb") do |csv|
    csv << Article.column_names
    Article.all.each do |article|
      csv << article.attributes.values
    end
  end
end
end
