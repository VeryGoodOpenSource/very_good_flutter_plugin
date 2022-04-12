#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = '{{project_name.snakeCase()}}_ios'
  s.version          = '0.0.1'
  s.summary          = 'An iOS implementation of the {{project_name.snakeCase()}} plugin.'
  s.description      = <<-DESC
  An iOS implementation of the {{project_name.snakeCase()}} plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }  
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.platform = :ios, '9.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }  
end
