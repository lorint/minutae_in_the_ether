class AddSampleFears < ActiveRecord::Migration[5.2]
  def change
    fear_names = ["Going to the dentist",
    "Having someone break into my flat",
    "Losing my hair",
    "I have an STD and I don't want others to find out",
    "Huge debt from Uni",
    "Getting caught for drink driving",
    "My mom leaving my dad",
    "Having the ice caps melt",
    "Finding bone fragments in my kebab",
    "Being alone",
    "Not being good enough at my job",
    "Becoming pregnant",
    "Scared of clowns",
    "Giving this 5 minute pitch at the Hackathon",
    "Not being able to keep good grades",
    "Knife crime",
    "Worrying that my neighbour is banging my girl while I'm gone",
    "Catching Coronavirus",
    "My girlfriend catching me with my boyfriend",
    "Don't know if I'll get a good job based on the major I've chosen",
    "If my girlfriend were to break up with me",
    "Being accepted for who I am",
    "The Home Office deporting me because I entered the UK illegally"]

    user_ids = User.order('id DESC').limit(fear_names.length).pluck(:id)

    fear_names.each_with_index do |fear_name, idx|
      user_id = user_ids[idx]
      fear = Aether::Fear.find_or_initialize_by(name: fear_name, author_id: user_id)
      Aether::UserFear.create(user_id: user_id, fear: fear) if fear.new_record? && fear.save
    end
  end
end
