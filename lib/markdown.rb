class MarkdownRenderer < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    if link =~ /^(.+?)\s*=+(\d+)(?:px|)$/
      # e.g. ![alt](url.png =100px)
      # e.g. ![alt](url.png =100)
      %(<img src="#{$1}" style="max-width: #{$2}px" alt="#{alt_text}">)
    elsif link =~ /^(.+?)\s*=+(\d+)(?:px|)x(\d+)(?:px|)$/
      # e.g. ![alt](url.png =30x50)
      %(<img src="#{$1}" style="max-width: #{$2}px; max-height: #{$3}px;" alt="#{alt_text}">)
    else
      %(<img src="#{link}" title="#{title}" alt="#{alt_text}">)
    end
  end
  def postprocess(full_document)
    Regexp.new(/\A<p>(.*)<\/p>\Z/m).match(full_document)[1] rescue full_document
  end
end
