module Watir
  module JSExecution

    #
    # Delegates script execution to Browser or IFrame.
    #
    def execute_script(script, *args)
      @query_scope.execute_script(script, *args)
    end

    #
    # Simulates JavaScript events on element.
    # Note that you may omit "on" from event name.
    #
    # @example
    #   browser.button(name: "new_user_button").fire_event :click
    #   browser.button(name: "new_user_button").fire_event "mousemove"
    #   browser.button(name: "new_user_button").fire_event "onmouseover"
    #
    # @param [String, Symbol] event_name
    #

    def fire_event(event_name)
      event_name = event_name.to_s.sub(/^on/, '').downcase

      element_call { execute_js :fireEvent, @element, event_name }
    end

    #
    # Flashes (change background color to a new color and back a few times) element.
    #
    # @example
    #   browser.text_field(name: "new_user_first_name").flash
    #   browser.text_field(name: "new_user_first_name").flash(color: "green", flashes: 3, delay: 0.05)
    #   browser.text_field(name: "new_user_first_name").flash(color: "yellow")
    #   browser.text_field(name: "new_user_first_name").flash(flashes: 4)
    #   browser.text_field(name: "new_user_first_name").flash(delay: 0.1)
    #
    # @param [String] color what color to flash with
    # @param [Integer] flashes number of times element should be flashed
    # @param [Integer, Float] delay how long to wait between flashes
    #
    # @return [Watir::Element]
    #

    def flash(color: 'red', flashes: 10, delay: 0)
      background_color = style("backgroundColor")
      element_color = element_call { execute_js(:backgroundColor, @element) }.strip

      #driver.execute_script("arguments[0].style.backgroundColor", @element)

      flashes.times do |n|
        nextcolor = n.even? ? color : background_color
        element_call { execute_js(:backgroundColor, @element, nextcolor) }
       # driver.execute_script("arguments[0].style.backgroundColor = arguments[1]", @element, nextcolor)
        sleep(delay)
      end

      element_call { execute_js(:backgroundColor, @element, element_color) }
      #driver.execute_script("arguments[0].style.backgroundColor = arguments[1]", @element, element_color)

      self
    end

    #
    # Focuses element.
    # Note that Firefox queues focus events until the window actually has focus.
    #
    # @see http://code.google.com/p/selenium/issues/detail?id=157
    #

    def focus
      element_call { execute_js(:focus, @element) }
      #element_call { driver.execute_script "return arguments[0].focus()", @element }
    end

    #
    # Returns inner HTML code of element.
    #
    # @example
    #   browser.div(id: 'shown').inner_html
    #   #=> "<div id=\"hidden\" style=\"display: none;\">Not shown</div><div>Not hidden</div>"
    #
    # @return [String]
    #

    def inner_html
      element_call { execute_js(:getInnerHtml, @element) }.strip
    end

    #
    # Returns inner Text code of element.
    #
    # @example
    #   browser.div(id: 'shown').inner_text
    #   #=> "Not hidden"
    #
    # @return [String]
    #

    def inner_text
      element_call { execute_js(:getInnerText, @element) }.strip
    end

    #
    # Returns outer (inner + element itself) HTML code of element.
    #
    # @example
    #   browser.div(id: 'shown').outer_html
    #   #=> "<div id=\"shown\"><div id=\"hidden\" style=\"display: none;\">Not shown</div><div>Not hidden</div></div>"
    #
    # @return [String]
    #

    def outer_html
      element_call { execute_js(:getOuterHtml, @element) }.strip
    end
    alias_method :html, :outer_html

    #
    # Returns text content of element.
    #
    # @example
    #   browser.div(id: 'shown').text_content
    #   #=> "Not shownNot hidden"
    #
    # @return [String]
    #

    def text_content
      element_call { execute_js(:getTextContent, @element) }.strip
    end

    #
    # Selects text on page (as if dragging clicked mouse across provided text).
    #
    # @example
    #   browser.legend.select_text('information')
    #

    def select_text(str)
      element_call { execute_js :selectText, @element, str }
    end

  end # JSExecution
end # Watir
