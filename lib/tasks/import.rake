namespace :import do
  desc "import the pages"
  task :pages => :environment do
    pages = YAML::load_file("#{RAILS_ROOT}/config/data/pages.yml")
    pages.each do |p|
      page = Page.new(p)
      page.save!
    end
  end
end

