activate :directory_indexes
activate :autoprefixer
activate :i18n

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "research"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

set :relative_links, true
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"
set :layout, "layouts/layout"

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Dynamic pages: Methods
data.en.strategies.each do |name, _|
  proxy "/methods/#{name}/index.html",
    "methods/template.html",
    locals: { name: name },
    locale: :en,
    ignore: true
end

data.ru.strategies.each do |name, _|
  proxy "/ru/methods/#{name}/index.html",
    "methods/template.html",
    locals: { name: name },
    locale: :ru,
    ignore: true
end

# Dynamic pages: Projects
data.en.projects.each do |name, _|
  proxy "/work/#{name}/index.html",
    "work/template.html",
    locals: { name: name },
    locale: :en,
    ignore: true
end

# Dynamic pages: Projects
data.ru.projects.each do |name, _|
  proxy "/ru/work/#{name}/index.html",
    "work/template.html",
    locals: { name: name },
    locale: :ru,
    ignore: true
end

ignore "methods/template.html"
ignore "work/template.html"

configure :development do
  activate :livereload
end

configure :build do
  activate :relative_assets
  activate :minify_css
  activate :minify_javascript
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
end
