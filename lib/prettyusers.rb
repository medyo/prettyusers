require "prettyusers/version"
require 'net/http'
require 'uri'
require 'json'
module Prettyusers
    class User
        @@fields = [
          :gender,
          :username,
          :title,
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

    # Build Count of results Uri (Max 100)
    def self.count_uri(count)
        (!count.nil? and (1..100).include?(count)) ? '?results='+count.to_s : '?results=1'
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

        response = Net::HTTP.start(uri.host) do |http|
            http.get uri.request_uri, 'User-Agent' => 'PrettyUsers' 
        end

         case response
            when Net::HTTPRedirection
            when Net::HTTPSuccess
              response = JSON.parse(response.body, symbolize_names: true)
            
              if(response[:results].count>0)
                  users = Array.new
                  response[:results].each do |u|

                      r = u[:user] # minifying :)
                      name = {:title =>r[:title], :firstname => r[:name][:first], :lastname => r[:name][:last]}
                      location = {:street => r[:location][:street], :city =>r[:location][:city], :state => r[:location][:state], :zip => r[:location][:zip]}
                     
                      u = User.new({:name => name,:username =>r[:username], :picture=>r[:picture],:gender => r[:gender],:location => location,:email => r[:email],:password =>r[:password], :md5_password =>r[:md5], :sha1_hash => r[:sha1], :phone => r[:phone], :cell => r[:cell], :SSN => r[:SSN]})
                      users.push(u)

                  end
                  users.count == 1 ? users.first : users
              end
            else
              response.error!
        end

        
    end

    def self.random(options = {})
        self.run(options[:gender],1)
    end

    def self.generate(options = {})
        self.run(options[:gender],options[:count])
    end

end