module Encryptor
     
     
     def encrypt_string(str)
          begin
               cipher_salt1 = salt1;
               cipher_salt2 = salt2;
               cipher = OpenSSL::Cipher.new('AES-128-ECB').encrypt;
               cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(cipher_salt1, cipher_salt2, 20_000, cipher.key_len);
               encrypted = cipher.update(str) + cipher.final;
               encrypted.unpack('H*')[0].upcase;
          rescue
               return false
          end
     end
          
     def decrypt_string(encrypted_str)
          begin
               cipher_salt1 = salt1;
               cipher_salt2 = salt2;
               cipher = OpenSSL::Cipher.new('AES-128-ECB').decrypt;
               cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(cipher_salt1, cipher_salt2, 20_000, cipher.key_len);
               decrypted = [encrypted_str].pack('H*').unpack('C*').pack('c*');
               
               cipher.update(decrypted) + cipher.final;
          rescue
               return false
          end
     end

     private
          def salt1
               return 'string-key-here-1'
          end
          
          def salt2
               return 'string-key-here-2'
          end

end