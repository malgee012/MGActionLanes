
# 这是远端的lane

# default_platform :ios 这两种都可以
default_platform(:ios)

# 执行的开始位置， 相当于main
platform :ios do

  desc "版本库的发布&更新"
  lane :mg_update_lib do |options|

	libName = options[:libName]
	message = options[:message]
  	tag = options[:tag]

    UI.message("👉 代码库名字： #{libName} \n👉 提交信息说明: #{message} \n👉 tag版本：#{tag}")

  end


end
