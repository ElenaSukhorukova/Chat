module LikeHelper
  def likes(message)
    heart_button = content_tag :div, class: "ui labeled button", tabindex: "0" do
      hart = 
        if message.likes.find_by(user: @user).present?
          "🧡"
        else
          "🤍"
        end
        
      concat content_tag(:div, hart, class: "ui red button")
      count = message.likes_count ||= '0'

      concat content_tag(:p, count, class: "ui basic red left pointing label")
    end.html_safe

    heart_button
  end
end
