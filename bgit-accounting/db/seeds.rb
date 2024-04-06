ActiveRecord::Base.transaction do
  user = User.create!(email: "buchhaltung@tfc-frankfurt.de")
  Bgit::Accounting::SeedService.call!(accountables: [user])
end
