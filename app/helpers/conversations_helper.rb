module ConversationsHelper
  def mini_persona_tag(user)
    "<span class=\"miniPersonaTag\"><span class=\"smIcon\"></span><span class=\"userName\">#{user.name}</span>"
  end
end
