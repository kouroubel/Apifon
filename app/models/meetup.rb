class Meetup
  include HTTParty
  
  base_uri "https://ars.apifon.com"
  #attr_reader :options


  # def initialize    #account balance
  #   request_date = DateTime.now.strftime('%a, %d %b %Y %H:%M:%S GMT')
  #   token = "9f18566c7c00fdefd6548761e2a957c3f773aa87591642e76787a644dab83188"
  #   secretKey = "Qii^I8EW5soW7&AB"
  #   endpoint = "/services/balance"
  #   body = ""
    
  #   sign_str = "POST" + "\n" + endpoint + "\n" + body + "\n" + request_date
    
  #   signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha256'), secretKey, sign_str)).strip()
  
  #   @options = 
  #   {
  #     headers: 
  #     {
  #       "Content-type" => "application/json",
  #       "Authorization" => 'ApifonWS ' + token + ":" + signature,
  #       "X-ApifonWS-Date" => request_date
  #     }
      
  #   }
  # end
  
  def initialize    #send sms
    request_date = DateTime.now.strftime('%a, %d %b %Y %H:%M:%S GMT')
    token = "9f18566c7c00fdefd6548761e2a957c3f773aa87591642e76787a644dab83188"
    secretKey = "Qii^I8EW5soW7&AB"
    endpoint = "/services/sms/send"
    # endpoint = "/services/im/send"
    
    bodyStr = '{
        "message": 
        {
          "text": "Hello There!",
          "sender_id": "TeamLink"
        },
        "callback_url": "https://yourserver/callback",
        "subscribers": [{
            "number": "306947260939"
        }
        ]
      }
      
    }'
    
#     bodyStr = '{
#     "message": {},
#     "callback_url": "https://yourserver/callback",
#     "im_channels": [{
#             "sender_id": "Teamlink",
#             "text": "50% discount on our membership fee if you renew your subscription today!"
#         }
#     ],
#     "subscribers": [{
#             "number": "306947260939"
#         }
#     ]
# }'

#############################################
    
    sign_str = "POST" + "\n" + endpoint + "\n" + bodyStr + "\n" + request_date
    
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), secretKey, sign_str)).strip()
  
    @options =  
    {
      headers: 
      {
        "Content-type" => "application/json",
        "Authorization" => 'ApifonWS ' + token + ":" + signature,
        "X-ApifonWS-Date" => request_date
      },
      body: bodyStr
    }
    
  end

  def get_data
    #self.class.post('/services/balance', @options)
    self.class.post('/services/sms/send', @options)
    #self.class.post('/services/im/send', @options)
  end
  
  def events
    if get_data.code.to_i == 200
      get_data.parsed_response
    else
      raise "Error posting to API"
    end
  end
  
end