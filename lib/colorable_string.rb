module ColorableString
  RGB_INDEX = {
    bluey: "139;130;253",
    white: "255;255;255"
  }.freeze

  refine String do
    def background_color(r_index, c_index)
      if (r_index + c_index).even?
        "\e[48;2;#{RGB_INDEX[:bluey]}m#{self}\e[0m"
      else
        "\e[48;2;#{RGB_INDEX[:white]}m#{self}\e[0m"
      end
    end
  end
end