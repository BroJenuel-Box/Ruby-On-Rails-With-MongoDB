require 'Encryptor'

module TokenManager
     include Encryptor

     def generate_token(user_id, username, usertype)
          extime = (Time.now + add_day(2)).to_i

          token = encrypt_string(user_id) + '.' + encrypt_string(username) + '.' + encrypt_string(usertype) + '.' + encrypt_string(extime.to_s);

          return token
     end

     def decrypt_token(token)
          if token.nil? || token.empty?
               return false
          end

          d = {};
          d_token = token.split('.').each_with_index do |item, index|
               case index
               when 0
                    d[:id] = decrypt_string(item)
               when 1
                    d[:username] = decrypt_string(item)
               when 2
                    d[:type] = decrypt_string(item)
               when 3
                    d[:token_ex] = decrypt_string(item)
               end
          end
          return d
     end

     private
          def add_day(day = 1)
               return 86400 * day.to_i
          end
end