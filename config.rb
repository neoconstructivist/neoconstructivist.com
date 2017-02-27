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

# Dynamic pages: Categories
data.en.projects.each do |name, project|
  if !project.category.nil?
    project.category.each do |category_name|
      proxy "categories/#{category_name.parameterize}/index.html",
        "categories/template.html",
        locals: { category_name: category_name },
        locale: :en,
        ignore: true
    end
  end
end

# Dynamic pages: Categories
data.en.projects.each do |name, project|
  if !project.category.nil?
    project.category.each do |category_name|
      proxy "/ru/categories/#{category_name.parameterize}/index.html",
        "categories/template.html",
        locals: { category_name: category_name },
        locale: :ru,
        ignore: true
    end
  end
end

# Dynamic pages: Domains
data.en.projects.each do |name, project|
  if !project.domain.nil?
    project.domain.each do |domain_name|
      proxy "domains/#{domain_name.parameterize}/index.html",
        "domains/template.html",
        locals: { domain_name: domain_name },
        locale: :en,
        ignore: true
    end
  end
end

# Dynamic pages: Domains
data.en.projects.each do |name, project|
  if !project.domain.nil?
    project.domain.each do |domain_name|
      proxy "/ru/domains/#{domain_name.parameterize}/index.html",
        "domains/template.html",
        locals: { domain_name: domain_name },
        locale: :ru,
        ignore: true
    end
  end
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
