Pod::Spec.new do |s|
  s.name         = "PYFMDB"
  s.version      = "0.0.5"
  s.summary      = "Operations library of sqlite base on FMDB"
  s.homepage     = "https://github.com/iterrypeng/PYFMDB"
  s.license      = "MIT"
  s.author       = { "pengyong" => "pengyong@veldasoft.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/iterrypeng/PYFMDB.git", :tag => s.version.to_s }
  s.source_files = "PYFMDB/*.{h,m}"
  s.platform	 = :ios,'6.0'
  s.requires_arc = true
  s.dependency   "FMDB", "~> 2.0"
end
