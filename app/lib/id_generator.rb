class IdGenerator
  @@vovels = "AEYOUI".split("")
  @@consonants = "BCDFGHJKLMNPQRSTVWXZ".split("")
  @@digits = ("1".."9").to_a
  def self.generate
    id = ""
    id << random_vowel
    id << random_consonant
    2.times { id << random_vowel }
    2.times { id << random_number }
    return id 
  end
  def self.random_vowel
   @@vovels.sample
  end

  def self.random_consonant
    @@consonants.sample
  end

  def self.random_number
    @@digits.sample
  end
end
