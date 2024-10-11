# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user =User.find_or_create_by!(email_address: "admin@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end
# Create 30 ancient history related tasks for the user
stories = [
  { title: "Research Ancient Egypt", description: "Study the pyramids and pharaohs of Ancient Egypt" },
  { title: "Explore Ancient Greece", description: "Learn about Greek philosophy, mythology, and city-states" },
  { title: "Investigate Roman Empire", description: "Examine the rise and fall of the Roman Empire" },
  { title: "Analyze Mesopotamian Civilizations", description: "Study Sumerians, Babylonians, and Assyrians" },
  { title: "Discover Ancient China", description: "Research the dynasties and inventions of Ancient China" },
  { title: "Explore Indus Valley Civilization", description: "Learn about the ancient cities of Harappa and Mohenjo-daro" },
  { title: "Study Mayan Civilization", description: "Investigate Mayan culture, architecture, and calendar systems" },
  { title: "Research Inca Empire", description: "Explore Machu Picchu and Inca engineering feats" },
  { title: "Analyze Persian Empire", description: "Study the reign of Cyrus the Great and Persian culture" },
  { title: "Investigate Ancient Carthage", description: "Learn about Carthaginian trade and conflicts with Rome" },
  { title: "Explore Viking Age", description: "Research Norse mythology and Viking expeditions" },
  { title: "Study Ancient Nubia", description: "Examine the kingdoms of Kush and Meroe" },
  { title: "Research Phoenician Civilization", description: "Learn about Phoenician trade and alphabet" },
  { title: "Analyze Hittite Empire", description: "Study the rise and fall of the Hittites in Anatolia" },
  { title: "Investigate Minoan Civilization", description: "Explore the palace of Knossos and Minoan art" },
  { title: "Study Aztec Empire", description: "Research Aztec religion and society" },
  { title: "Explore Ancient Japan", description: "Learn about Jomon and Yayoi periods in Japanese history" },
  { title: "Research Etruscan Civilization", description: "Examine Etruscan art and influence on Rome" },
  { title: "Analyze Parthian Empire", description: "Study the Parthian rivalry with Rome" },
  { title: "Investigate Scythian Culture", description: "Learn about nomadic Scythian art and warfare" },
  { title: "Study Olmec Civilization", description: "Research the mother culture of Mesoamerica" },
  { title: "Explore Ancient Korea", description: "Examine the Three Kingdoms period of Korea" },
  { title: "Research Gupta Empire", description: "Study the Golden Age of Ancient India" },
  { title: "Analyze Mycenaean Greece", description: "Investigate the world of Homer's epics" },
  { title: "Study Aksumite Empire", description: "Learn about ancient Ethiopia and its monuments" },
  { title: "Explore Zapotec Civilization", description: "Research Monte Alban and Zapotec culture" },
  { title: "Investigate Xiongnu Empire", description: "Study the nomadic empire that challenged Ancient China" },
  { title: "Research Nabataean Kingdom", description: "Explore Petra and Nabataean trade networks" },
  { title: "Analyze Khmer Empire", description: "Examine Angkor Wat and Khmer civilization" },
  { title: "Study Toltec Civilization", description: "Investigate Toltec influence in Mesoamerica" }
]

protocols = ['http', 'https']
domains = ['example.com', 'historystudy.org', 'ancientcivilizations.net', 'archaeologyonline.edu', 'historicalresearch.io']

stories.each do |task_data|
  random_protocol = protocols.sample
  random_domain = domains.sample
  random_url = "#{random_domain}/#{stories.sample[:title].parameterize}"
  random_title = stories.sample[:title]
  random_description = stories.sample[:description]
  user.stories.create!(
    title: random_title,
    url_protocol: random_protocol,
    description: random_description,
    url: random_url,
    created_at: Date.today - rand(1..30).days,
  )
end

