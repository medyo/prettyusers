# Pretty Users

This gem allows you to generate pretty user's information with an avatar, name, password, email, gender, phone ... 

Based on http://randomuser.me/ api

## Installation

Add this line to your application's Gemfile:

    gem 'prettyusers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prettyusers
    
Restart your server

## Demo View

![alt tag](https://raw.github.com/medyo/prettyusers/master/demo_prettyusers.png)

## Usage

### One Random user ###
gender is optional (male or female)

``` ruby
Prettyusers.random({:gender => 'male'})
```

### Multi users ###
Gender and count are optional

Gender accepts : male or female

Count accepts a value between 1 and 5


``` ruby
Prettyusers.generate({:gender => 'female', :count => 3})
```

### Access data ###

``` ruby
user = Prettyusers.random.email
users = Prettyusers.generate(:count => 2).first.email
```

`name[:firtname]`, `name[:lastname]`,`picture`,`location[:street]`,`location[:city]`,`location[:zip]`,`location[:state]`, `gender`, `email`, `password`, `md5_password`, `sha1_hash`,`phone`,`cell`,`SSN` 


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
