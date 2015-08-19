module ApplicationHelper
	def full_title(page_title = '')
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
end





#retrive.authenticated?(:saved_doc,token)
  # def retrieve_document
  #   token_digest = digest(params[:token])
  #   @retrieve_document_id = SavedDocumentLink.find_by(saved_doc_digest: token_digest)
  #   @retrieve_document = SavedDocumentDetail.find_by(saved_document_id: @retrieve_document_id.saved_document_id)
  # end

  # @link = "http://localhost:3000/api/v1/saved_document_detail/retrieve_document?token=" + @saved_document_token.to_s

  # def authenticated?(attribute, token)
  #   digest = send("#{attribute}_digest")
  #   return false if digest.nil?
  #   BCrypt::Password.new(digest).is_password?(token)
  # end
  # puts saved_document_detail.saved_document_link.saved_doc_digest.to_s
