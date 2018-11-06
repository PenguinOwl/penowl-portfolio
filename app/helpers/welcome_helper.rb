module WelcomeHelper
  def random_name
    res = case rand(5)
    when 0 then "Human"
    when 1 then "User"
    when 2 then "Fella"
    when 3 then "Thinker"
    when 4 then "Bruce Lee"
    when 5 then "WW91ciB0aW1lIGhhcyBiZWVuIHdhc3RlZA=="
    end
  end
end
