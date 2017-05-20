Pod::Spec.new do |s|
    s.name         = 'GH_SearchView'
    s.version      = '1.0.0'
    s.summary      = 'A simple custom search box, easier to use the search function.
    s.homepage     = 'http://www.guohuaden.com'
    s.license      = 'MIT'
    s.authors      = {'Wheat' => 'wheatden@guohuaden.com'}
    s.platform     = :ios, '5.0'
    s.source       = {:git => 'https://github.com/Wheat-Qin/GH_SearchView.git', :tag => s.version}
    s.source_files = 'GH_SearchView/**/*.{h,m}'
    s.requires_arc = true
end