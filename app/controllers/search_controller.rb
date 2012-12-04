# -*- coding: utf-8 -*
#require 'net/http'
#require 'net/https'

require 'open-uri'
require 'uri'
require 'pp'
require 'json'

# SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed 対策
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE



class SearchController < ApplicationController
  # instagram登録手順
  # http://d.hatena.ne.jp/keito7/20120117/1326808645

  # step1
  # https://api.instagram.com/oauth/authorize/?client_id=0a1df617f982414e84fbad84aa0e2087&redirect_uri=http://localhost&response_type=code

  # step2
  #curl \-F 'client_id=0a1df617f982414e84fbad84aa0e2087' \
  #-F 'client_secret=93b80c0e97ef4fae9a8f06f115346320' \
  #-F 'grant_type=authorization_code' \
  #-F 'redirect_uri=http://localhost' \
  #-F 'code=fb2ae8baa6e1458f900f1bb8697aca5b' \https://api.instagram.com/oauth/access_token

  # API関連
  #https://api.instagram.com/v1/media/popular?access_token=223375.0a1df61.d452361af51c44efbe72437d0ab64764
  #https://api.instagram.com/v1/tags/search?q=food&access_token=223375.0a1df61.d452361af51c44efbe72437d0ab64764

  @@access_token = "223375.0a1df61.d452361af51c44efbe72437d0ab64764"

  @data         = []
  @error        = false
  
  def index
    logger.debug "@@@ index @@@"

    @i = params['i']
    if @i == "search" then
      q = params['q']
      if q != nil then
        @target_tag    = q
        @@target_path  = "/#{@target_tag}"
        @@target_url   = "https://api.instagram.com/v1/tags#{@@target_path}/media/recent?access_token="  
        @@base_url     = @@target_url + "#{@@access_token}"
        
        logger.debug(@target_tag)
        create_data
      end
    end    
  end
  def create_data
    logger.debug(@@base_url)
    json = parse_json(@@base_url)
    #json = p_json(@@base_url)
    #logger.debug(json.inspect)
    
    if json == nil then
      return
    end
    #redirect_to :back  unless json['meta']['code'] && json['meta']['code'] == 200
    
    @data = extract_data(json['data'])
    #logger.debug(@data.inspect)
    #logger.debug "@@@ result @@@"
  end
  def p_json(url)
    #logger.debug "@@@ p_json @@@"
    html = open('https://api.instagram.com/v1/tags/car/media/recent?access_token=223375.0a1df61.d452361af51c44efbe72437d0ab64764').read
    json = JSON.parser.new(html)
    logger.debug(json.inspect)
  end
  def parse_json(url)
    begin
      str = open(url) do |data|
        data.read
      end
      #logger.debug "@@@ parse_json finish @@@"
    rescue
      #logger.debug "@@@ rescue open @@@"
      @error = $!.message + $@.to_s
      #redirect_to :back
      return
    end
    
    begin
      json = JSON.parse(str)
    rescue
      #logger.debug "@@@ rescue parse @@@"
      @error = $!.message + $@.to_s
      #redirect_to :back
    end
    json
  end
  def extract_data(data)
    #logger.debug "@@@ extract_data @@@"
    return if data.empty? #TODO
    
    result = []
    data.each do |v|
      hash = {}
      hash['thumbnail']    = v['images']['thumbnail']['url']
      hash['low']          = v['images']['low_resolution']['url']
      hash['standard']     = v['images']['standard_resolution']['url']
      hash['created_time'] = v['created_time']
      hash['link']         = v['link']
      hash['likes']        = v['likes']
      hash['location']     = v['location']
      hash['caption']      = v['caption'] ? v['caption']['text'] : nil
      
      result.push hash
    end
    result
  end
end


