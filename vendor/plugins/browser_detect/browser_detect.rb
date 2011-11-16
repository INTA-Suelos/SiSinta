module BrowserDetect
  # Define browser groupings (mobile, robots, etc.)
  # Also define complex queries like IE where we weed out user agents that pose as IE
  # The default case just checks if the user agent contains the query string
  def browser_is? query
    query = query.to_s.strip.downcase
    result = case query
    when /^ie(\d+)$/
      ua.index("msie #{$1}") && !ua.index('opera') && !ua.index('webtv')
    when 'ie'
      ua.match(/msie \d/) && !ua.index('opera') && !ua.index('webtv')
    when 'yahoobot'
      ua.index('yahoo! slurp')
    when 'mozilla'
      ua.index('gecko') || ua.index('mozilla')
    when 'webkit'
      ua.match(/webkit|iphone|ipad|ipod/)
    when 'safari'
      ua.index('safari') && !ua.index('chrome')
    when 'ios'
      ua.match(/iphone|ipad|ipod/)
    when /^robot(s?)$/
      ua.match(/googlebot|msnbot/) || browser_is?('yahoobot')
    when 'mobile'
      browser_is?('ios') || ua.match(/android|webos|mobile/)
    else
      ua.index(query)
    end
    not (result.nil? || result == false)
  end

  # Determine the version of webkit.
  # Useful for determing rendering capabilities
  # For instance, Mobile Webkit versions lower than 532 don't handle webfonts very well (intermittent crashing when using multiple faces/weights)
  def browser_webkit_version
    if browser_is? 'webkit'
      match = ua.match(%r{\bapplewebkit/([\d\.]+)\b})
      match[1].to_f if (match)
    end or 0
  end

  def browser_is_mobile?
    browser_is? 'mobile'
  end

  # Gather the user agent and store it for use.
  def ua
    @ua ||= begin
      request.env['HTTP_USER_AGENT'].downcase
    rescue
      ''
    end
  end
end

#require 'railtie' if defined? Rails
if ::Rails.version < "3.1"
  require 'jquery/rails/railtie'
else
  require 'jquery/rails/engine'
end
