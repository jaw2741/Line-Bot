#require 'Net/http'
require 'line/bot'
class KamigoController < ApplicationController

	protect_from_forgery with: :null_session
	
	
	def eat
	 render plain: "吃土啦"
	end
	
	def request_headers
		render plain: request.headers.to_h.reject{ |key, value|
      key.include? '.'
    }.map{ |key, value|
      "#{key}: #{value.class}"
    }.sort.join("\n")
	end
	

	
	def request_body
		render plain: request.body
	end
	
	
	def response_headers
		response.headers['5566'] = 'QQ'
		render plain: response.headers.to_h.map{ |key, value|
		"#{key}: #{value}"
		}.sort.join("\n")
	end
	
	def show_response_body
		puts "===這是設定前的response.body:#{response.body}==="
		render plain: "虎哇花哈哈哈"
		puts "===這是設定後的response.body:#{response.body}==="
	end
	
	
	

	def sent_request
		
		
		uri = URI('http://localhost:3000/kamigo/eat')
		http = Net::HTTP.new(uri.host, uri.port)
		http_request = Net::HTTP::Get.new(uri)
		http_response = http.request(http_request)

    render plain: JSON.pretty_generate({
      request_class: request.class,
      response_class: response.class,
      http_request_class: http_request.class,
      http_response_class: http_response.class
    })
	end
	
	
	def translate_to_korean(message)
		"#{message}油~" 
	end
	
	
	
	def webhook
		# Line Bot API 物件初始化
		# 設定回覆文字
		
		
		reply_text = keyword_reply(received_text)
  
  
  
		# 取得 reply token
		#reply_token = params['events'][0]['replyToken']

		## 設定回覆訊息
		

		
		
		# 傳送訊息
		response = reply_to_line(reply_text)
		
		
    
		# 回應 200
		head :ok
		
		
	end 
	
	
	def line
	  @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = '531602758cfda62ab1e439ce30c7b76b'
      config.channel_token =
	  'VQhfQdr41STP5Ix1oB8JBcmEegp0fZKCbgesUx4/Y3jgxwsQ6/kWjHus8iOHJeByZ9iVYcpT3khRBwmWixNvqbhyMsA2w1F/FWC37gt82URitfraichptrLOL/UuVxJ3KxutKVVDhxPm+ocgKC4fVAdB04t89/1O/w1cDnyilFU='
    }
	end
	
	# 傳送訊息到 line
	def reply_to_line(reply_text)
	
		return nil if reply_text.nil?
	
	
		# 取得 reply token
		reply_token = params['events'][0]['replyToken']
		
		# 設定回覆訊息
		message = {
		type: 'text',
		text: reply_text
	  }
		
    
		# 傳送訊息
		response = line.reply_message(reply_token, message)
	end
	
	
	 # 取得對方說的話
	def received_text
	
		message = params['events'][0]['message']
		message['text'] unless message.nil?
		
	end

	# 關鍵字回覆
	def keyword_reply(received_text)
	
		keyword_mapping = {
		'王震文已詳讀' => '時維澤已詳讀',
		'收到' => 'X04RT96',
		
		'@Zu.' => '時維澤已詳讀',
		
		
		'我難過' => '神曲支援：https://www.youtube.com/watch?v=T0LfHEwEXXw&feature=youtu.be&t=1m13s',
		
		
		'0' => '時維澤
07:30>>16:30
加班0小時
離場時間16:30',
				
				
		'0.5' => '時維澤
07:30>>16:30
16:30>>17:00
加班0.5小時
離場時間17:00',
		
		
		'1' => '時維澤
07:30>>16:30
16:30>>17:30
加班1小時
離場時間17:30',
				  
		'1.5' => '時維澤
07:30>>16:30
16:30>>18:00
加班1.5小時
離場時間18:00',
		
		
		'2' => '時維澤
07:30>>16:30
16:30>>18:30
加班2小時
離場時間18:30',
				  
		'2*' => '時維澤
07:30>>16:30
17:00>>19:00
加班2小時
離場時間19:00',
		
		
				  
		'2.5' => '時維澤
07:30>>16:30
17:00>>19:30
加班2.5小時
離場時間19:30',
		
		
		'3' => '時維澤
07:30>>16:30
17:00>>20:00
加班3小時
離場時間20:00',
				  
		'3.5' => '時維澤
07:30>>16:30
17:00>>20:30
加班3.5小時
離場時間20:30',
		
		
		'4' => '時維澤
07:30>>16:30
17:00>>21:00
加班4小時
離場時間21:00',
				  
		'4.5' => '時維澤
07:30>>16:30
17:00>>21:30
加班4.5小時
離場時間21:30',
		
		
		'5' => '時維澤
07:30>>16:30
17:00>>22:00
加班5小時
離場時間22:00',
		
		'5.5' => '時維澤
07:30>>16:30
17:00>>22:30
加班5.5小時
離場時間22:30',
		
		'我今天請假' => '裝病就裝病',
		
		
		
		'*' => '時維澤今天請假',
		't7' => '我明天支援無塵室07:00',
		
		'9' => 'Sorry, 程式有點問題',
		'up' => '同樓上'
		
		
		
		
		}
    
	
	
	
	
	
	
		# 查表
		keyword_mapping[received_text]
	
	end
	
	  
  
  
  
end
