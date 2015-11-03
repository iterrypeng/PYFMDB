Pod::Spec.new do |s|
  s.name         = "PYFMDB"
  s.version      = "0.0.1"
  s.summary      = "Operations library of sqlite base on FMDB"
  s.homepage     = "https://github.com/iterrypeng/PYFMDB"
  s.license      = "Apache"
  s.author       = { "pengyong" => "pengyong@veldasoft.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/iterrypeng/PYFMDB.git", :tag => "0.0.1" }
  s.source_files = "PYFMDB/PYFMDB.{h,m}"
  s.requires_arc = true
  s.dependency   "FMDB", "~> 2.0"
end
