activate :directory_indexes
activate :autoprefixer
activate :i18n

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

activate :contentful do |f|
  f.space         = { contentful: ENV["SPACE_ID"] }
  f.access_token  = ENV["CONTENTFUL_API_KEY"]
  f.all_entries   = true
  f.content_types = { 
    strategies: "strategy",
    projects: "project", 
  }
end
