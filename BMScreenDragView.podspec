Pod::Spec.new do |s|
s.name         = 'BMScreenDragView'
s.version      = '0.0.1'
s.summary      = '任意拖拽View'
s.homepage     = 'https://github.com/asiosldh/BMScreenDragView'
s.license      = 'MIT'
s.authors      = {'asiosldh' => 'asiosldh@163.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/asiosldh/BMScreenDragView.git', :tag => s.version}
s.source_files = 'BMScreenDragViewDemo/BMScreenDragViewDemo/BMScreenDragView/**/*.{h,m}'
s.requires_arc = true
end
