class SiteGenerator
  def make_index!
    index = <<-HTML
    <!DOCTYPE html>
    <html>
    <head>
      <title>Movies</title>
    </head>
    <body>
      <ul>
        #{ Movie.all.map { |movie| "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"}.join }
      </ul>
    </body>
    </html>
    HTML
    File.open("_site/index.html", "w+") { |f| f.puts index }
  end

  def generate_pages!
    template = File.read("lib/templates/movie.html.erb")
    erb = ERB.new(template)
    Movie.all.each do |movie|
      File.open("_site/movies/#{movie.url}", "w+") { |f| f.puts erb.result(binding) }
    end
  end
end
