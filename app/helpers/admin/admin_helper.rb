module Admin::AdminHelper
  def admin_quotes(path)
    @page = path.blank? ? @page : Page.find_by_path(path)
    quotes = Quote.find_all_by_page_id(@page) unless @page.blank?
    quotes.collect do |qte|
      <<-S
      <tr>
        <td>#{quote qte}</td>
        <td>#{link_to 'Edit', edit_admin_quote_path(qte)}</td>
      </tr>
      S
    end.join('')
  end
end
