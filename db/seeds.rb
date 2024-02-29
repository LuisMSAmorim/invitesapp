admin = User.create(email: "admin@email.com", password: "ABC123456!#", role: :admin)

user = User.create(email: "user@email.com", password: "ABC123456!#", role: :user)

company_1 = Company.create(name: "Company1", ceo: "John Doe")
company_2 = Company.create(name: "Company2", ceo: "Doe John")
company_3 = Company.create(name: "Company3", ceo: "Dohn Joe")

Invite.create(title: "Evento_1", description: "Vai ser um evento show de bola", date: Date.today, user: user, company: company_1)
Invite.create(title: "Evento_2", description: "Um grande evento", date: Date.today, user: user, company: company_2)
