activate :aria_current
activate :autoprefixer
activate :i18n

# Disable warnings
Haml::TempleEngine.disable_option_validator!

set :css_dir, "assets/stylesheets"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :js_dir, "assets/javascripts"
set :layout, "layouts/layout"
set :markdown,
  autolink: true,
  fenced_code_blocks: true,
  footnotes: true,
  highlight: true,
  smartypants: true,
  strikethrough: true,
  tables: true,
  with_toc_data: true
set :markdown_engine, :redcarpet

page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

# Dynamic pages: Methods
data.contentful.strategies.each do |id, method|
  proxy "/methods/#{method.title.parameterize}/index.html",
    "methods/template.html",
    locals: { method: method },
    locale: :en,
    ignore: true
end

# Dynamic pages: Projects
data.contentful.projects.each do |id, project|
  proxy "/work/#{project.slug}/index.html",
    "work/template.html",
    locals: { project: project },
    locale: :en,
    ignore: true
end

ignore "methods/template.html"
ignore "work/template.html"
ignore "categories/template.html"
ignore "domains/template.html"

activate :contentful do |f|
  f.space         = { contentful: ENV["SPACE_ID"] }
  f.access_token  = ENV["CONTENTFUL_API_KEY"]
  f.all_entries   = true
  f.content_types = { 
    strategies: "strategy",
    projects: "project", 
  }
end

configure :development do
  activate :livereload do |reload|
    reload.no_swf = true
  end
end

configure :production do
  activate :gzip
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end
