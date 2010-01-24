class String
  def pluralize_with_override(n = 0)
    self.send(n == 1 ? :to_s : :pluralize_without_override)
  end
  alias_method_chain :pluralize, :override
end
