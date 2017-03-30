module ApplicationHelper
  include SMSEasyHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_featured(file)
    items = []
    File.readlines(file, quote_char: "\x00").each do |row|
      items << row.strip
    end
    # items << Todo.where('featured = ?', true).pluck('todo')
    # @todos.flatten.uniq
  end

  def mood_list(user)
    if not user
      return default_list.to_json
    elsif not MoodList.find_by(user_id: user.id)
      create_mood_list user
    end

    list = decrypt(MoodList.find_by(user_id: user.id).moods).split(',').map do |mood|
      { text: mood.strip }
    end

    list.to_json
  end

  def default_list
    %w(Terrible Bad Neutral Good Great).map { |mood| { text: mood } }
  end

  def create_mood_list(user)
    MoodList.create(
      user: user,
      moods: encrypt('Terrible, Bad, Neutral, Good, Great')
    )
  end

  def get_day(datetime)
    datetime.rfc2822.gsub(/ \d{2}:\d{2}:\d{2} \+\d{4}$/, '')
  end

  def get_time(datetime)
    datetime.time.strftime('%l:%M %P')
  end

  def cipher
    OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  end

  def decrypt(value)
    c = cipher.decrypt
    c.key = Digest::SHA256.digest(ENV['PHONE_SALT'])
    c.update(Base64.decode64(value.to_s)) + c.final
  end

  def encrypt(value)
    c = cipher.encrypt
    c.key = Digest::SHA256.digest(ENV['PHONE_SALT'])
    Base64.encode64(c.update(value.to_s) + c.final)
  end

  def encrypt_param(param)
    return param if param.blank?
    encrypt param
  end

  def decrypt_property(property)
    return property if property.blank?
    decrypt property
  end

  def different_user?(resource)
    not resource.user == current_user
  end
end
