namespace 'gwss' do
  desc "(Re-)Generate the secret token"
  task generate_secret: :environment do
    include ActiveSupport
    File.open("#{Rails.root}/config/initializers/secret_token.rb", 'w') do |f|
      f.puts "#{Rails.application.class.parent_name}::Application.config.secret_key_base = '#{SecureRandom.hex(64)}'"
    end
  end
 
  desc "Populate (overwrite!) marketing and announcement content blocks from config files"
  task populate_content_blocks: :environment do

    marketingblock = ContentBlock.find_or_create_by(name: 'marketing_text')
    f = File.open("#{Rails.root}/config/locales/content_blocks/marketing.html")
    marketingblock.value = f.read
    marketingblock.save

    announcementblock = ContentBlock.find_or_create_by(name: 'announcement_text')
    f = File.open("#{Rails.root}/config/locales/content_blocks/announcement_text.html")
    announcementblock.value = f.read
    announcementblock.save

    aboutblock = ContentBlock.find_or_create_by(name: 'about_page')
    f = File.open("#{Rails.root}/config/locales/content_blocks/about.html")
    aboutblock.value = f.read
    aboutblock.save

    #TODO: Add featured researcher(s).  More complex as there can be
    #      multiple featured researchers; how to load them so that the
    #      desired one is surfaced on the home page, and other questions
    #      would need to be addressed.
  end

  desc "Create GW ScholarSpace user roles"
  task create_roles: :environment do
    adminrole = Role.find_or_create_by(name: 'admin')
    adminrole.save

    contentadminrole = Role.find_or_create_by(name: 'content-admin')
    contentadminrole.save
  end
  
  desc "Queues a job to (re)generate the sitemap.xml"
  task "sitemap_queue_generate" => :environment do
    SitemapRegenerateJob.perform_later
  end
  
end

end
