return if Rails.env.production?

User.destroy_all

user = User.create!(
  email_address: "admin@app.localhost",
  password: "password"
)

other_user = User.create!(
  email_address: "other@app.localhost",
  password: "password"
)

attrs = {
  "Mitch Hedberg" => Faker::Quote.fetch_all("quote.mitch_hedberg"),
  "Matz" => Faker::Quote.fetch_all("quote.matz")
}.flat_map do |author, quotes|
  quotes.map do |quote|
    {
      title: author,
      content: quote,
      user_id: user.id
    }
  end
end.shuffle

attrs.each_with_index do |attr, index|
  attr[:title] = "#{index} #{attr[:title]}"
end

attrs += [
  {title: nil, content: "", user_id: other_user.id}
]

Note.insert_all(attrs)
Note.rebuild_full_text_search
