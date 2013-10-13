require "prettyusers/version"
require 'net/http'
require 'uri'
require 'json'
module Prettyusers
    class User
        @@fields = [
          :gender,
          :name,
          :location,
          :email,
          :password,
          :md5_password,
          :sha1_hash,
          :phone,
          :cell,
          :SSN,
          :picture
        ]
    
        @@fields.each do |field|
          attr_accessor field
        end

        def initialize(attributes = {})
            attributes.each do |k,v|
              instance_variable_set("@#{k}", v) unless v.nil?
            end
        end
    end


    @@api_ul = 'http://api.randomuser.me/'
    
    # Build Gender Uri
    def self.gender_uri(gender)
        (!gender.nil? and ['male','female'].include? gender.downcase) ? '&gender='+gender : '' 
    end

    # Build Count of results Uri (Max 5)
    def self.count_uri(count)
        (!count.nil? and (1..5).include?(count)) ? '?results='+count.to_s : '?results=1'
    end

    # Exec the request
    def self.run(gender,count)
        gender  = self.gender_uri(gender)
        count   = self.count_uri(count)
        uri     = @@api_ul+count

        if (!gender.empty?)
            uri = @@api_ul+count+gender
        end
        
        uri  = URI.parse(uri)
        http = Net::HTTP.new(uri.host, uri.port)

        http.start do |connection|
            response = connection.send_request(:get, uri.request_uri)
            response = JSON.parse(response.body, symbolize_names: true)
            
            if(response[:results].count>0)
                users = Array.new
                response[:results].each do |u|

                    r = u[:user] # minifying :)
                    name = {:firstname => r[:name][:first], :lastname => r[:name][:last]}
                    location = {:street => r[:location][:street], :city =>r[:location][:city], :state => r[:location][:state], :zip => r[:location][:zip]}
                   
                    u = User.new({:name => name,:picture=>r[:picture],:gender => r[:gender],:location => location,:email => r[:email],:password =>r[:password], :md5_hash =>r[:md5_hash], :sha1_hash => r[:sha1_hash], :phone => r[:phone], :cell => r[:cell], :SSN => r[:SSN], })
                    users.push(u)

                end
                users.count == 1 ? users.first : users
            end
        end

        
    end

    def self.random(options = {})
        self.run(options[:gender],1)
    end

    def self.generate(options = {})
        self.run(options[:gender],options[:count])
    end

end