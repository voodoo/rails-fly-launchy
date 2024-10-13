user_emails = ["user@domain.com", "user1@domain.com", "user2@domain.com", "user3@domain.com", "user4@domain.com"]
user_emails.each do |email|
  user = User.find_or_create_by!(email_address: email) do |user|
    user.password = "password"
    user.password_confirmation = "password"
  end
end

# Create 30 ancient history related stories
stories = [
  { title: "The Great Pyramid of Giza: Marvel of Ancient Engineering", description: "Explore the construction and significance of the last standing wonder of the ancient world.", url: "www.nationalgeographic.com/history/article/giza-pyramids", url_protocol: "https://" },
  { title: "Uncovering the Secrets of Machu Picchu", description: "Discover the mysteries of the Incan citadel high in the Andes Mountains.", url: "www.smithsonianmag.com/travel/what-machu-picchu-tells-us-about-the-incas-127213990/", url_protocol: "https://" },
  { title: "The Rise and Fall of the Roman Empire", description: "Examine the factors that led to Rome's dominance and eventual collapse.", url: "www.history.com/topics/ancient-rome/roman-empire", url_protocol: "https://" },
  { title: "Decoding the Rosetta Stone", description: "Learn how this ancient artifact unlocked the secrets of Egyptian hieroglyphs.", url: "www.britishmuseum.org/collection/object/Y_EA24", url_protocol: "https://" },
  { title: "The Terracotta Army of Emperor Qin Shi Huang", description: "Explore the vast underground army that guarded China's first emperor.", url: "www.worldhistory.org/Terracotta_Army/", url_protocol: "https://" },
  { title: "Unveiling the Mysteries of Stonehenge", description: "Investigate the theories behind this prehistoric monument's construction and purpose.", url: "www.english-heritage.org.uk/visit/places/stonehenge/history-and-stories/", url_protocol: "https://" },
  { title: "The Lost City of Petra: Jordan's Ancient Wonder", description: "Discover the rock-cut architecture of the Nabataean capital.", url: "whc.unesco.org/en/list/326/", url_protocol: "https://" },
  { title: "Cleopatra: The Last Pharaoh of Ancient Egypt", description: "Uncover the life and reign of one of history's most famous queens.", url: "www.biography.com/political-figures/cleopatra-vii", url_protocol: "https://" },
  { title: "The Hanging Gardens of Babylon: Myth or Reality?", description: "Investigate the evidence for one of the Seven Wonders of the Ancient World.", url: "www.ancient.eu/article/129/the-hanging-gardens-of-babylon-a-modern-study/", url_protocol: "https://" },
  { title: "Pompeii: A City Frozen in Time", description: "Explore the remarkably preserved Roman city destroyed by Mount Vesuvius.", url: "www.pompeii.it/en/", url_protocol: "https://" },
  { title: "The Colosseum: Rome's Iconic Amphitheater", description: "Examine the history and architecture of this ancient entertainment venue.", url: "www.italyguides.it/en/lazio/rome/ancient-rome/colosseum", url_protocol: "https://" },
  { title: "Deciphering the Maya Script", description: "Learn about the breakthroughs in understanding the complex Maya writing system.", url: "www.scientificamerican.com/article/the-maya-codex-the-oldest-surviving-book-from-the-americas/", url_protocol: "https://" },
  { title: "The Parthenon: Symbol of Ancient Greek Civilization", description: "Explore the history and significance of Athens' most famous temple.", url: "www.ancient.eu/parthenon/", url_protocol: "https://" },
  { title: "Tutankhamun's Tomb: The Discovery that Captivated the World", description: "Relive Howard Carter's famous discovery of the boy king's intact tomb.", url: "www.nationalgeographic.com/culture/article/tutankhamun", url_protocol: "https://" },
  { title: "The Nazca Lines: Ancient Geoglyphs of the Peruvian Desert", description: "Investigate the theories behind these massive ground drawings.", url: "whc.unesco.org/en/list/700/", url_protocol: "https://" },
  { title: "Göbekli Tepe: Rewriting the History of Human Civilization", description: "Examine the world's oldest known temple complex and its implications for understanding early human societies.", url: "www.smithsonianmag.com/history/gobekli-tepe-the-worlds-first-temple-83613665/", url_protocol: "https://" },
  { title: "The Library of Alexandria: Lost Wonder of the Ancient World", description: "Explore the history and legacy of the greatest library of antiquity.", url: "www.worldhistory.org/Library_of_Alexandria/", url_protocol: "https://" },
  { title: "Chichen Itza: Heart of the Maya World", description: "Discover the astronomical significance and architectural wonders of this Maya city.", url: "www.history.com/topics/ancient-americas/chichen-itza", url_protocol: "https://" },
  { title: "The Silk Road: Ancient Highway of Culture and Commerce", description: "Trace the routes that connected East and West for centuries.", url: "www.nationalgeographic.org/encyclopedia/silk-road/", url_protocol: "https://" },
  { title: "Persepolis: The Ceremonial Capital of the Persian Empire", description: "Explore the ruins of this magnificent ancient city built by Darius I.", url: "whc.unesco.org/en/list/114/", url_protocol: "https://" },
  { title: "The Dead Sea Scrolls: Ancient Texts Revealed", description: "Learn about the discovery and significance of these ancient Jewish manuscripts.", url: "www.deadseascrolls.org.il/", url_protocol: "https://" },
  { title: "Angkor Wat: Cambodia's Ancient Temple City", description: "Examine the largest religious monument in the world and its Hindu-Buddhist heritage.", url: "whc.unesco.org/en/list/668/", url_protocol: "https://" },
  { title: "The Lighthouse of Alexandria: Lost Wonder of the Ancient World", description: "Investigate the history and possible appearance of this ancient marvel.", url: "www.ancient.eu/article/130/the-lighthouse-of-alexandria/", url_protocol: "https://" },
  { title: "Newgrange: Ireland's Ancient Tomb Older Than the Pyramids", description: "Discover the Neolithic passage tomb aligned with the winter solstice.", url: "www.worldheritageireland.ie/bru-na-boinne/built-heritage/newgrange/", url_protocol: "https://" },
  { title: "The Indus Valley Civilization: Ancient Urban Planning", description: "Explore the sophisticated cities of Harappa and Mohenjo-daro.", url: "www.harappa.com/", url_protocol: "https://" },
  { title: "The Acropolis of Athens: Crown Jewel of Ancient Greece", description: "Examine the history and architecture of this iconic ancient citadel.", url: "whc.unesco.org/en/list/404/", url_protocol: "https://" },
  { title: "Teotihuacan: The City of the Gods", description: "Uncover the mysteries of this massive pre-Columbian city in Mexico.", url: "www.mexicodesconocido.com.mx/teotihuacan-city-of-the-gods.html", url_protocol: "https://" },
  { title: "The Great Wall of China: World's Longest Fortification", description: "Trace the history and construction of this monumental ancient structure.", url: "www.chinahighlights.com/greatwall/", url_protocol: "https://" },
  { title: "Easter Island's Moai: The Silent Sentinels", description: "Investigate the theories behind the creation and purpose of these enigmatic statues.", url: "www.easterisland.travel/easter-island-facts-and-info/moai-statues/", url_protocol: "https://" },
  { title: "The Phoenicians: Ancient Mariners and Alphabet Creators", description: "Learn about the far-reaching influence of these ancient Mediterranean traders.", url: "www.nationalgeographic.com/culture/article/phoenicians-lebanon-mediterranean-trade-carthage", url_protocol: "https://" }
]

stories.each do |story_data|
  user = User.all.sample
  story = user.stories.create!(
    title: story_data[:title],
    url_protocol: story_data[:url_protocol],
    description: story_data[:description],
    url: story_data[:url],
    created_at: Date.today - rand(1..30).days,
  )
  # TODO: Fix this - model is not saving
  story.votes.create(user: user)
end

root_user = Current.root_user
root_user.tasks.create!(
  title: "Todo to todone",
  description: "Do the done thine",
  due_date: Date.today + 1.week
)

root_user.tasks.create!(
  title: "Make sure this Root user is ok",
  description: "Does not screw up all the things",
  state: 1,
  due_date: Date.today + 3.week
)

root_user.tasks.create!(
  title: "This task is not done",
  description: "Do the thing",
  state: 2,
)
