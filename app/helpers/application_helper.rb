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
  
  def months_option_helper
    today = Time.now
    # today = Date.parse("2014. 4. 2")
    (today.month..4).to_a
  end
  
  def shorten_helper(len, msg)
    if msg.length >= len
      msg[0..len]+"..."
    else
      msg
    end
  end
end
