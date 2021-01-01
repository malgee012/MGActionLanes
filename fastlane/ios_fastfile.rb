
# 这是远端的lane

# default_platform :ios 这两种都可以
default_platform(:ios)

# 执行的开始位置， 相当于main
platform :ios do

  desc "私有版本库的发布&更新"
  lane :mg_update_lib do |options|

	libName = options[:libName]
	message = options[:message]
  	tag = options[:tag]

    public_str = options[:is_public]

    is_public = "true".eql?(is_public)


    UI.message(">>>>>  #{is_public}   #{"false".eql?(is_public)}   #{"false" == is_public}")

    UI.message("👉 代码库名字： #{libName}  tag版本：#{tag}  提交信息: #{message} public:#{is_public} ")

    # 验证podspec
    pod_lib_lint(
    	allow_warnings: true,
    	use_libraries: true,
    	no_clean: true,
    	verbose: false,
    	)
    git_add(path: ".")
    git_commit(path: ".", message: "#{message}")
    push_to_git_remote

	# 判断是否已经存在了这个tag, 如果存在先移除
    if git_tag_exists(tag: tag) 
    	remove_git_tag(tag:tag, libName:libName, is_public:is_public)
    	UI.message("👉 #{libName}代码库已经存在#{tag}标签, 现在删除#{tag}标签🏷")
    end

    add_git_tag(tag:tag)  
	UI.message("👉 已经为#{libName}代码库添加新的#{tag}标签🏷")

	push_git_tags  # git push origin --tags  这是推送全部未推送过的本地标签
	UI.message("👉 #{tag}标签现在已经推送到远端了")

	pod_push(
		path: "#{libName}.podspec",
		allow_warnings: true,
		use_libraries: true,
    	verbose: false,
    	# sources:["https://github.com/cocoapods/specs.git", "https://cdn.cocoapods.org/"]
		)

    UI.message("👉 #{libName}代码库更新成功！！！🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀")

  end



end
