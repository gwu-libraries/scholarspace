namespace 'gwss' do
  desc "(Re-)Generate the secret token"
  task generate_secret: :environment do
    include ActiveSupport
    File.open("#{Rails.root}/config/initializers/secret_token.rb", 'w') do |f|
      f.puts "#{Rails.application.class.parent_name}::Application.config.secret_key_base = '#{SecureRandom.hex(64)}'"
    end
  end
 
  desc "Populate (overwrite!) content blocks from config files"
  task populate_content_blocks: :environment do
    path_to_content_blocks = 'config/locales/content_blocks/'

    mt = ContentBlock.find_by_name('marketing_text')
    f = File.open(path_to_content_blocks + 'marketing.html')
    mt.value = f.read
    mt.save

    fr = ContentBlock.find_by_name('featured_researcher')
    f = File.open(path_to_content_blocks + 'featured_researcher.html')
    fr.value = f.read
    fr.save

    at = ContentBlock.find_by_name('announcement_text')
    f = File.open(path_to_content_blocks + 'announcement_text.html')
    at.value = f.read
    at.save
  end

end
