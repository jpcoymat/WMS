require 'resque'

redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")
Resque.redis = redis_config[Rails.env]
Resque.redis.namespace = "resque:company:namespace"
