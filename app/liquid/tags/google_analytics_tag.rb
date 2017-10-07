# Returns a Google Analytics tag.
#
# Usage:
#
# {% ga 'UA-XXXXX-X' %}

class Tags::GoogleAnalyticsTag < ::Liquid::Tag
  Syntax = /(#{::Liquid::QuotedFragment}+)?/

  def initialize(tag_name, markup, tokens)
    if markup =~ Syntax
      @account_id = $1.gsub('\'', '')
    else
      raise ::Liquid::SyntaxError.new("Syntax Error in 'Google Analytics Tag' - Valid syntax: {% ga <account_id> %}")
    end

    super
  end

  def render(context)
    %{
      <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
        ga('create', '#{@account_id}', 'auto');
        ga('send', 'pageview');
      </script>
    }
  end
end
