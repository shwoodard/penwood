namespace :import do
  desc "import the pages"
  task :pages => :environment do
    pages = YAML::load_file("#{RAILS_ROOT}/config/data/pages.yml")
    pages.each do |p|
      page = Page.find_by_path(p["path"])
      
      if page
        page.attributes = p
      else
        page = Page.new(p)
      end
      
      page.save!
    end
  end
end

