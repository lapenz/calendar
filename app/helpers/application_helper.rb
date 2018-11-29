module ApplicationHelper
  def nav_link(link_text, link_path, http_method=nil)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, class: class_name) do
      if http_method
        link_to(link_text, link_path, method: http_method)
      else
        link_to(link_text, link_path)
      end
    end
  end

  def time_format(datetime)
    datetime.strftime('%H:%M') unless datetime.blank?
  end


  def self.decrypt(key, text)
    cipher = OpenSSL::Cipher.new('AES-128-CBC').decrypt
    cipher.key = key
    s = [text].pack("H*").unpack("C*").pack("c*")

    cipher.update(s) + cipher.final
  end

  def decrypt(key, text)
    ApplicationHelper.decrypt(key, text)
  end

  def self.encrypt(key, text)
    cipher = OpenSSL::Cipher.new('AES-128-CBC').encrypt
    cipher.key = key
    s = cipher.update(text) + cipher.final

    s.unpack('H*')[0].upcase
  end

  def encrypt(key, text)
    ApplicationHelper.encrypt(key, text)
  end

  def domain_url
    text = request.protocol + request.domain
    text +=  ':' + request.port.to_s unless request.port.blank? || request.port == 80
  end
end
