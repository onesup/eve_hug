module ApplicationHelper
  def valid_error_class_helper(model_name, column_name, origin_class)
    if model_name.errors[column_name].any?
      origin_class + " valid_error"
    else
      origin_class
    end
  end
  def days_option_helper
    today = Time.now
    # today = Date.parse("2014. 4. 2")
    if Time.now.month == 3
      finish_of_this_month = 31 
    else
      finish_of_this_month = 27
    end
    (today.day..finish_of_this_month).to_a
  end
  
  def shorten_helper(len, msg)
    if msg.length >= len
      msg[0..len]+"..."
    else
      msg
    end
  end
  
  def days_helper(day)
    week_days = {0 => '월', 1 => '화', 2 => '수', 3 => '목', 4 => '금', 5 => '토', 6 => '일'}
    print_week_day = (DateTime.now-DateTime.now.wday+day).beginning_of_day.strftime('%Y-%m-%d')+"(일)"
    print_week_day
  end
  
  def months_option_helper
    today = Time.now
    (today.month..5).to_a
  end
  
  def week_paginate_next(current_page,link_path)
    link_to "다음주", eval(link_path+"("+(current_page.to_i-1).to_s+")")
  end

  def week_paginate_prev(current_page, link_path)
    link_to "지난주", eval(link_path+"("+(current_page.to_i+1).to_s+")")
  end
  
end
