platform :ios, '9.0'
inhibit_all_warnings!

target 'Playtomic Architecture Assignment' do
  pod 'Resolver'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRelay' 
  
  target 'Playtomic Architecture Assignment UnitTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end