require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Scholarspace
  VERSION = "v1.4.0"

  class Application < Rails::Application
    
    config.generators do |g|
      g.test_framework :rspec, :spec => true
    end


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.gw_affiliations = {
      "ACCESS Center for Advancement of Research in Distance Education" => "ACCESS Center for Advancement of Research in Distance Education",
      "Accountancy" => "Accountancy",
      "Advocacy in the Global Environment" => "Advocacy in the Global Environment",
      "Africana Studies" => "Africana Studies",
      "Allergy, Asthma & Sinus Center Breast Care Center" => "Allergy, Asthma & Sinus Center Breast Care Center",
      "American and Saudi Arabian Dialogue Education Center" => "American and Saudi Arabian Dialogue Education Center",
      "American Studies" => "American Studies",
      "Anatomy & Regenerative Biology" => "Anatomy & Regenerative Biology",
      "Anesthesiology & Critical Care Medicine" => "Anesthesiology & Critical Care Medicine",
      "Anthropology" => "Anthropology",
      "Art Therapy" => "Art Therapy",
      "Asian Studies" => "Asian Studies",
      "Biochemistry & Molecular Medicine" => "Biochemistry & Molecular Medicine",
      "Bioinformatics" => "Bioinformatics",
      "Biological Sciences" => "Biological Sciences",
      "Biomedical Engineering" => "Biomedical Engineering",
      "Biostatistics Center" => "Biostatistics Center",
      "Brazil Initiative" => "Brazil Initiative",
      "Business & Finance Law " => "Business & Finance Law ",
      "Capitol Archaeological Institute, GW" => "Capitol Archaeological Institute, GW",
      "Center for Advanced Study of Human Paleobiology" => "Center for Advanced Study of Human Paleobiology",
      "Center for Applied Developmental Science & Neuroeducation" => "Center for Applied Developmental Science & Neuroeducation",
      "Center for Biomimetics and Bioinspired Engineering" => "Center for Biomimetics and Bioinspired Engineering",
      "Center for Economic Research" => "Center for Economic Research",
      "Center for Equity and Excellence in Education" => "Center for Equity and Excellence in Education",
      "Center for Excellence in Public Leadership" => "Center for Excellence in Public Leadership",
      "Center for Injury Prevention & Control" => "Center for Injury Prevention & Control",
      "Center for Innovative Media" => "Center for Innovative Media",
      "Center for Intelligent Systems Research" => "Center for Intelligent Systems Research",
      "Center for International Science and Technology Policy" => "Center for International Science and Technology Policy",
      "Center for Latin American Issues" => "Center for Latin American Issues",
      "Center for Law, Economics, and Finance" => "Center for Law, Economics, and Finance",
      "Center for Otolaryngology Microsurgery Education & Training (COMET)" => "Center for Otolaryngology Microsurgery Education & Training (COMET)",
      "Center for Pelvic Health" => "Center for Pelvic Health",
      "Center for Preparedness & Resilience" => "Center for Preparedness & Resilience",
      "Center for Quantum Computing, Information, Logic & Topology" => "Center for Quantum Computing, Information, Logic & Topology",
      "Center for Rehabilitation Counseling Research and Education" => "Center for Rehabilitation Counseling Research and Education",
      "Center for Sexual Health" => "Center for Sexual Health",
      "Center for Urban and Environmental Research" => "Center for Urban and Environmental Research",
      "Center for Washington Area Studies" => "Center for Washington Area Studies",
      "Center on Aging, Health, & Humanities" => "Center on Aging, Health, & Humanities",
      "Center on Education Policy" => "Center on Education Policy",
      "Chemistry" => "Chemistry",
      "China Policy Program" => "China Policy Program",
      "Civil & Environmental Engineering" => "Civil & Environmental Engineering",
      "Classical & Near Eastern Languages & Civilizations" => "Classical & Near Eastern Languages & Civilizations",
      "Classical Acting" => "Classical Acting",
      "Clinical & Translational Science Institute at Children's National (CTSI-CN)" => "Clinical & Translational Science Institute at Children's National (CTSI-CN)",
      "Clinical Learning and Simulation Skills (CLASS) Center" => "Clinical Learning and Simulation Skills (CLASS) Center",
      "Clinical Research & Leadership" => "Clinical Research & Leadership",
      "Cocoran Arts & Humanities" => "Cocoran Arts & Humanities",
      "Cocoran Graphic Design" => "Cocoran Graphic Design",
      "Competition Law Center" => "Competition Law Center",
      "Computational Biology Institute" => "Computational Biology Institute",
      "Computer Science" => "Computer Science",
      "Corcoran Art and the Book" => "Corcoran Art and the Book",
      "Corcoran Art Education" => "Corcoran Art Education",
      "Corcoran Digital Media Design" => "Corcoran Digital Media Design",
      "Corcoran Exhibition Design" => "Corcoran Exhibition Design",
      "Corcoran Fine Art" => "Corcoran Fine Art",
      "Corcoran Fine Art Photography" => "Corcoran Fine Art Photography",
      "Corcoran Interior Architecture and Design" => "Corcoran Interior Architecture and Design",
      "Corcoran New Media Photojournalism" => "Corcoran New Media Photojournalism",
      "Corcoran Photojournalism" => "Corcoran Photojournalism",
      "Corcoran School of the Arts and Design" => "Corcoran School of the Arts and Design",
      "Counseling & Human Development" => "Counseling & Human Development",
      "Culture in Global Affairs Program" => "Culture in Global Affairs Program",
      "Curriculum & Pedagogy" => "Curriculum & Pedagogy",
      "Cyber Center for National & Economic Security" => "Cyber Center for National & Economic Security",
      "Cyber Security Policy & Research Institute" => "Cyber Security Policy & Research Institute",
      "Cybersecurity, Strategy, and Information Management" => "Cybersecurity, Strategy, and Information Management",
      "Dean Dinwoodey Center for Intellectual Property Studies" => "Dean Dinwoodey Center for Intellectual Property Studies",
      "Decision Studies" => "Decision Studies",
      "Dermatology" => "Dermatology",
      "District of Columbia Developmental Center for AIDS Research, (DC D-CFAR)" => "District of Columbia Developmental Center for AIDS Research, (DC D-CFAR)",
      "Division of Information Technology" => "Division of Information Technology",
      "Division of Operations" => "Division of Operations",
      "Division of Student Affairs" => "Division of Student Affairs",
      "Documentary Center" => "Documentary Center",
      "Dr. Cyrus & Myrtle Katzen Cancer Research Center" => "Dr. Cyrus & Myrtle Katzen Cancer Research Center",
      "Ear, Nose, & Throat Center" => "Ear, Nose, & Throat Center",
      "East Asian Languages & Literatures" => "East Asian Languages & Literatures",
      "Economics" => "Economics",
      "Educational Leadership" => "Educational Leadership",
      "Eleanor Roosevelt Papers Project" => "Eleanor Roosevelt Papers Project",
      "Electrical & Computer Engineerin" => "Electrical & Computer Engineerin",
      "Emergency Medicine" => "Emergency Medicine",
      "Engineering Management & Systems Engineering" => "Engineering Management & Systems Engineering",
      "English" => "English",
      "Environmental & Energy Law" => "Environmental & Energy Law",
      "Environmental & Occupational Health" => "Environmental & Occupational Health",
      "Environmental Resource Policy" => "Environmental Resource Policy",
      "Environmental Studies" => "Environmental Studies",
      "Epidemiology & Biostatistics" => "Epidemiology & Biostatistics",
      "Epilepsy Center (SMHS)" => "Epilepsy Center (SMHS)",
      "Epilepsy Center (MFA)" => "Epilepsy Center (MFA)",
      "European and Eurasian Studies" => "European and Eurasian Studies",
      "European Union Research Center" => "European Union Research Center",
      "Exercise & Nutrition Sciences" => "Exercise & Nutrition Sciences",
      "Film Studies" => "Film Studies",
      "Finance (GWSB)" => "Finance (GWSB)",
      "Finance Division" => "Finance Division",
      "Fine Arts & Art History" => "Fine Arts & Art History",
      "First Federal Congress Project" => "First Federal Congress Project",
      "Forensic Psychology" => "Forensic Psychology",
      "Forensic Sciences" => "Forensic Sciences",
      "Geography" => "Geography",
      "Geological Sciences" => "Geological Sciences",
      "Global Center for Political Engagement" => "Global Center for Political Engagement",
      "Global Communication" => "Global Communication",
      "Global Gender Program" => "Global Gender Program",
      "Global Health" => "Global Health",
      "Global Media Institute" => "Global Media Institute",
      "Global Women's Institute" => "Global Women's Institute",
      "Government Procurement Law" => "Government Procurement Law",
      "Graduate School of Political Management" => "Graduate School of Political Management",
      "GW Cancer Center" => "GW Cancer Center",
      "GW Cancer Institute" => "GW Cancer Institute",
      "GW Center for Integrative Medicine" => "GW Center for Integrative Medicine",
      "GW Cold War Group (GWCW)" => "GW Cold War Group (GWCW)",
      "GW Disapora Program" => "GW Disapora Program",
      "GW Heart & Vascular Institute" => "GW Heart & Vascular Institute",
      "GW HIV/AIDS Institute" => "GW HIV/AIDS Institute",
      "GW Institute for Neuroscience " => "GW Institute for Neuroscience ",
      "GW Institute for Nuclear Studies" => "GW Institute for Nuclear Studies",
      "GW Institute for Spirituality & Health (GWish)" => "GW Institute for Spirituality & Health (GWish)",
      "GW Institute for Massively Parallel Applications and Computing Technology (IMPACT)" => "GW Institute for Massively Parallel Applications and Computing Technology (IMPACT)",
      "GW Institute of Public Policy" => "GW Institute of Public Policy",
      "GW Libraries" => "GW Libraries",
      "Health Policy & Management" => "Health Policy & Management",
      "Health Policy Forum, National" => "Health Policy Forum, National",
      "Health Workforce Research Center, GW" => "Health Workforce Research Center, GW",
      "History" => "History",
      "Homeland Security Policy Institute" => "Homeland Security Policy Institute",
      "Human Hookworm Vaccine Initiative / Sabin Vaccine Institute PDP " => "Human Hookworm Vaccine Initiative / Sabin Vaccine Institute PDP ",
      "Human and Organizational Learning" => "Human and Organizational Learning",
      "Human Services & Social Justice" => "Human Services & Social Justice",
      "Information Systems & Technology Management" => "Information Systems & Technology Management",
      "Information, Technology and Globalization Program" => "Information, Technology and Globalization Program",
      "Instituite for Global and International Studies" => "Instituite for Global and International Studies",
      "Institute for Biomedical Engineering" => "Institute for Biomedical Engineering",
      "Institute for Biomedical Sciences" => "Institute for Biomedical Sciences",
      "Institute for Communitarian Policy Studies" => "Institute for Communitarian Policy Studies",
      "Institute for Computer Graphics" => "Institute for Computer Graphics",
      "Institute for Constitutional History" => "Institute for Constitutional History",
      "Institute for Corporate Responsibility" => "Institute for Corporate Responsibility",
      "Institute for Crisis, Disaster and Risk Management" => "Institute for Crisis, Disaster and Risk Management",
      "Institute for Ethnographic Research" => "Institute for Ethnographic Research",
      "Institute for European, Russian, and Eurasian Studies" => "Institute for European, Russian, and Eurasian Studies",
      "Institute for Immigrants in America" => "Institute for Immigrants in America",
      "Institute for Integrating Statistics in Decision Sciences" => "Institute for Integrating Statistics in Decision Sciences",
      "Institute for International Economic Policy" => "Institute for International Economic Policy",
      "Institute for Magnetics Research" => "Institute for Magnetics Research",
      "Institute for Materials Science" => "Institute for Materials Science",
      "Institute for Mathematical Sciences" => "Institute for Mathematical Sciences",
      "Institute for MEMS and VLSI Technologies" => "Institute for MEMS and VLSI Technologies",
      "Institute for Middle East Studies" => "Institute for Middle East Studies",
      "Institute for Nanotechnology" => "Institute for Nanotechnology",
      "Institute for Public Diplomacy & Global Communication" => "Institute for Public Diplomacy & Global Communication",
      "Institute for Reliability and Risk Analysis" => "Institute for Reliability and Risk Analysis",
      "Institute for Security and Conflict Studies" => "Institute for Security and Conflict Studies",
      "Institute for Space Policy" => "Institute for Space Policy",
      "Institute for Sustainability Research, Education and Policy" => "Institute for Sustainability Research, Education and Policy",
      "Integrated Information, Security, and Technology" => "Integrated Information, Security, and Technology",
      "Integrative Systems Biology" => "Integrative Systems Biology",
      "Intellectual Property Law" => "Intellectual Property Law",
      "Interior Architecture & Design" => "Interior Architecture & Design",
      "International & Comparitive Law" => "International & Comparitive Law",
      "International Affairs" => "International Affairs",
      "International Business" => "International Business",
      "International Development Studies" => "International Development Studies",
      "International Science and Technology Policy" => "International Science and Technology Policy",
      "International Trade and Investment Policy" => "International Trade and Investment Policy",
      "James F. Humphreys Complex Litigation Center" => "James F. Humphreys Complex Litigation Center",
      "Journalism & Mass Communication" => "Journalism & Mass Communication",
      "Judaic Studies" => "Judaic Studies",
      "Landscape Design" => "Landscape Design",
      "Latin American and Hemispheric Studies" => "Latin American and Hemispheric Studies",
      "Latino Health Research Center" => "Latino Health Research Center",
      "Law Firm Management" => "Law Firm Management",
      "Legislative Affairs" => "Legislative Affairs",
      "LGBT Health" => "LGBT Health",
      "Linguistics" => "Linguistics",
      "Litigation & Dispute Resolution" => "Litigation & Dispute Resolution",
      "Management" => "Management",
      "Marketing" => "Marketing",
      "Mathematics" => "Mathematics",
      "McCormick Genomic and Proteomic Center (MGPC)" => "McCormick Genomic and Proteomic Center (MGPC)",
      "Mechanical & Aerospace Engineering" => "Mechanical & Aerospace Engineering",
      "Media and Strategic Communication" => "Media and Strategic Communication",
      "Medicine" => "Medicine",
      "Medieval and Early Modern European Studies Institute" => "Medieval and Early Modern European Studies Institute",
      "Microbiology, Immunology, & Tropical Medicine" => "Microbiology, Immunology, & Tropical Medicine",
      "Middle East Studies" => "Middle East Studies",
      "Midge Smith Center for Evaluation Effectiveness" => "Midge Smith Center for Evaluation Effectiveness",
      "Mind-Brain Institute" => "Mind-Brain Institute",
      "Museum Studies" => "Museum Studies",
      "Music" => "Music",
      "National Crash Analysis Center" => "National Crash Analysis Center",
      "National Security & U.S. Foreign Relations Law" => "National Security & U.S. Foreign Relations Law",
      "Neurological Surgery" => "Neurological Surgery",
      "Neurology" => "Neurology",
      "Obstetrics & Gynecology" => "Obstetrics & Gynecology",
      "Office of Dean for Academic Affairs" => "Office of Dean for Academic Affairs",
      "Office of Emergency Management" => "Office of Emergency Management",
      "Office of Entrepreneurship" => "Office of Entrepreneurship",
      "Office of Graduate Student Assistantships and Fellowships" => "Office of Graduate Student Assistantships and Fellowships",
      "Office of Human Research" => "Office of Human Research",
      "Office of Industry/Corporate Research" => "Office of Industry/Corporate Research",
      "Office of Laboratory Safety" => "Office of Laboratory Safety",
      "Office of Non Degree Students" => "Office of Non Degree Students",
      "Office of Parent Services" => "Office of Parent Services",
      "Office of Student Opportunities" => "Office of Student Opportunities",
      "Office of Sustainability" => "Office of Sustainability",
      "Office of Technology Transfer" => "Office of Technology Transfer",
      "Office of The General Counsel" => "Office of The General Counsel",
      "Office of The President" => "Office of The President",
      "Office of the Provost" => "Office of the Provost",
      "Office of the Vice President for Research" => "Office of the Vice President for Research",
      "Office of University Special Events" => "Office of University Special Events",
      "Ophthalmology" => "Ophthalmology",
      "Organizational Sciences & Communication" => "Organizational Sciences & Communication",
      "Orthopaedic Surgery" => "Orthopaedic Surgery",
      "Paralegal Studies" => "Paralegal Studies",
      "Partnerships for International Strategies in Asia" => "Partnerships for International Strategies in Asia",
      "Pathology" => "Pathology",
      "Peace Studies" => "Peace Studies",
      "Pediatrics" => "Pediatrics",
      "Pharmacology & Physiology" => "Pharmacology & Physiology",
      "Philosophy" => "Philosophy",
      "Physical Therapy & Health Care Sciences" => "Physical Therapy & Health Care Sciences",
      "Physician Assistant Studies" => "Physician Assistant Studies",
      "Physics" => "Physics",
      "Police and Security Studies" => "Police and Security Studies",
      "Political Communication" => "Political Communication",
      "Political Communication and Governance" => "Political Communication and Governance",
      "Political Management" => "Political Management",
      "Political Science" => "Political Science",
      "Prevention & Community Health" => "Prevention & Community Health",
      "Professional Psychology" => "Professional Psychology",
      "Project on Humanitarian Governance" => "Project on Humanitarian Governance",
      "Prostate Cancer Clinic" => "Prostate Cancer Clinic",
      "Psychiatry & Behavioral Sciences" => "Psychiatry & Behavioral Sciences",
      "Psychology" => "Psychology",
      "Public Leadership" => "Public Leadership",
      "Publishing" => "Publishing",
      "Radiology" => "Radiology",
      "Real Estate & Urban Development" => "Real Estate & Urban Development",
      "Regulatory Studies Center" => "Regulatory Studies Center",
      "Religion" => "Religion",
      "Research Center for Neglected Diseases of Poverty" => "Research Center for Neglected Diseases of Poverty",
      "Rising Powers Initiative" => "Rising Powers Initiative",
      "Rodham Institute" => "Rodham Institute",
      "Romance, German & Slavic Languages & Literatures" => "Romance, German & Slavic Languages & Literatures",
      "Ronald Reagan Institute of Emergency Medicine" => "Ronald Reagan Institute of Emergency Medicine",
      "School of Media & Public Affairs" => "School of Media & Public Affairs",
      "School of Nursing" => "School of Nursing",
      "Security and Safety Leadership" => "Security and Safety Leadership",
      "Security Policy Studies" => "Security Policy Studies",
      "Sigur Center for Asian Studies" => "Sigur Center for Asian Studies",
      "Sociology" => "Sociology",
      "Solar Institute,  GW" => "Solar Institute,  GW",
      "Special Education & Disability Studies" => "Special Education & Disability Studies",
      "Speech & Hearing Sciences" => "Speech & Hearing Sciences",
      "Statistics" => "Statistics",
      "Strategic Management & Public Policy" => "Strategic Management & Public Policy",
      "Strategic Public Relations" => "Strategic Public Relations",
      "Student Organization" => "Student Organization",
      "Surgery" => "Surgery",
      "Sustainable Urban Planning" => "Sustainable Urban Planning",
      "Taiwan Education and Research Program" => "Taiwan Education and Research Program",
      "Theatre & Dance" => "Theatre & Dance",
      "Trachtenberg School of Public Policy & Public Administration" => "Trachtenberg School of Public Policy & Public Administration",
      "Trauma Center" => "Trauma Center",
      "Undergraduate Public Health" => "Undergraduate Public Health",
      "University Human Resources" => "University Human Resources",
      "University Writing" => "University Writing",
      "Urology" => "Urology",
      "US-Japan Legislative Exchange Program" => "US-Japan Legislative Exchange Program",
      "W. M. Keck Institute for Proteomics Technology and Applications" => "W. M. Keck Institute for Proteomics Technology and Applications",
      "Washington Institute of Surgical Education (WISE)" => "Washington Institute of Surgical Education (WISE)",
      "Women's Studies" => "Women's Studies",
    }
  end
end
