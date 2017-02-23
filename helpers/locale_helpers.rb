module LocaleHelpers
  def ldata
    data[I18n.locale]
  end

  def locale_path(path, options={})
    lang = options[:language] ? options[:language] : I18n.locale.to_s
    lang == "en" ? "/#{path}" : "/#{lang}/#{path}"
  end 
end
