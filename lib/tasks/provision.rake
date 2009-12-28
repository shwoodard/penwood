namespace :provision do
  task :admin_user => :environment do
    admin_user = User.find_by_last_name('Rand')
    admin_user.delete if admin_user
    admin_user = User.new(:email => "doug@penwoodpartners.com", :password => 'daw7852', :password_confirmation => 'daw7852', :first_name => 'Doug', :last_name => 'Woodard')
    admin_user.admin = true
    admin_user.save!
    admin_user.activate!
    admin_user.business.save!
    puts "\nAdmin User Provisioned\n"
  end
  
  task :basic_user => :environment do
    user = User.find_by_last_name('Woodard')
    user.delete if user
    user = User.new(:email => "sam.woodard@akqa.com", :password => 'v8n4m3', :password_confirmation => 'v8n4m3', :first_name => 'Sam', :last_name => 'Woodard', :business_attributes => {:name => "AKQA_basic_user", :business_type_id => BusinessType.find_by_value('Service').id, :primary_location_attributes => {:primary => true, :address_attributes => {:zip => 94107}}})
    user.save!
    user.activate!
    user.business.save!
    puts "\nBasic User Provisioned\n"
  end
  
  task :all_users => :environment do
    users = YAML::load(File.open("#{RAILS_ROOT}/config/development_users.yml"))
    
    users.each do |user_email_format|
      user = User.find_by_email(user_email_format)
      user.delete if user
      first_name = user_email_format.split('@')[0]
      user = User.new(:email => user_email_format, :password => first_name, :password_confirmation => first_name, :first_name => first_name, :last_name => 'Doe', :business_attributes => {:name => "AKQA", :business_type_id => BusinessType.find_by_value('Service').id, :primary_location_attributes => {:primary => true, :address_attributes => {:zip => 94107}}})
      user.admin = true
      user.save!
      user.activate!
      user.business.save!
      puts "\nUser, #{user_email_format}, Provisioned\n"
    end
  end
end
