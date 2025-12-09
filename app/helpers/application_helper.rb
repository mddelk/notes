module ApplicationHelper
  def flash_color type
    case type
    in "notice"
      "bg-green-50 dark:bg-green-950 border border-green-400"
    in "alert"
      "bg-red-50 dark:bg-red-950 border border-red-400"
    end
  end

  # Reference icons from a consolidated icons.svg
  #
  # - https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Element/use
  # - https://medium.com/@hayavuk/complete-guide-to-svg-sprites-7e202e215d34
  #
  def svg_icon name, class: ""
    tag.svg class: + " text-zinc-950 dark:text-zinc-200" do
      tag.use href: image_path("icons.svg") + "#icon-#{name}"
    end
  end
end
