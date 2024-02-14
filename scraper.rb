require "httparty" 
require "nokogiri"
require "csv"

news_scrapers = [] 
50.times do |i|

    response = HTTParty.get("http://csbc.edu.ua/index.php?str=#{i+1}.html")

    document = Nokogiri::HTML(response.body)

    NewsScraper = Struct.new(:url, :image, :name )



        html_products = document.css("div.one_half")

    html_products.each do |html_product| 

        url = html_product.css("a.btn.medium").attribute("href")
        image = html_product.css("img").attribute("src")
        name = html_product.css("h4").text 

        news_scraper = NewsScraper.new(url, image, name ) 

        news_scrapers.push(news_scraper) 
    end

    csv_headers = ["url", "image", "name" ] 
    CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv| 

        news_scrapers.each do |news_scraper| 
            csv << news_scraper 
        end 
    end
end