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
data.strategies.each do |name, _|
  proxy "/methods/#{name}/index.html",
    "/methods/template.html",
    locals: { name: name },
    ignore: true
end

# Dynamic pages: Projects
data.projects.each do |name, _|
  proxy "/work/#{name}/index.html",
    "/work/template.html",
    locals: { name: name },
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
