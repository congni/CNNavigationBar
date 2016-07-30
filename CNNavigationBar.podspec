Pod::Spec.new do |s|
  s.name         = 'CNNavigationBar'
  s.version      = '1.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/congni/CNNavigationBar.git'
  s.authors      = { "葱泥" => "983818495@qq.com" }
  s.summary      = '自定义NavigationBar'
  s.description      = <<-DESC
                      A longer description of U in Markdown format.

                      * 自定义NavigationBar
                      * pod使用方法: pod "CNNavigationBar"
                      * Try to keep it short, snappy and to the point.
                      * Finally, don't worry about the indent, CocoaPods strips it!
                      DESC

  s.ios.deployment_target = '7.0'
  s.source       =  { :git => "https://github.com/congni/CNNavigationBar.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'CNNavigationBar/*'
  s.public_header_files = 'CNNavigationBar/*.{h}'

  s.dependency 'CNIconLabel', '~> 1.0.2'
end