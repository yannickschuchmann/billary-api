# ActiveModelSerializers.config.adapter = :json_api
ActiveModelSerializers.config.adapter = :json

Mime::Type.register "application/json", :json, %w( text/x-json application/jsonrequest application/vnd.api+json )