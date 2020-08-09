class BruisedThumbRender < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %(<div class="columns">
      <div class="column is-8 is-offset-2">
      <img src="#{link}" title="#{title}" alt="#{alt_text}"> 
      </div>
      </div>)
  end

  def block_code(code, language)
    CodeRay.scan(code, language).div
  end
end
