

# default_platform :ios 这两种都可以
default_platform(:ios)

# 执行的开始位置， 相当于main
platform :ios do

  desc "远端的lane"
  lane :MG_lane do |options|

    name = options[:name]
    age = options[:age]

    UI.message("🚀name: #{name} age: #{age}")

  end


end
