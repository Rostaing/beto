class ContactMailer < ApplicationMailer

	def contact(post)
		@post = post
		mail (to: 'beto.nous@gmail.com', subject: 'Sujet de test')
	end
end
