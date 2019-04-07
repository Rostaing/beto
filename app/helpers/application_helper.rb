module ApplicationHelper
	def comment_count
		if @post.comments.count <= 1 
			"Comment"
		else
			"Comments"
		end
	end

	def post_number
		@post = Post.count
		if @post == 1
			 "#{@post} NEWS AVAILABLE!"
		else
			"#{@post} NEWS AVAILABLE!"
		end
	end

	def page_title(title)

		base_title = "Beto"
		if title.empty?
			base_title
		else

			"#{base_title} - #{title}"
		end
	end
end
