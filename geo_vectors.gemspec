# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geo_vectors}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kristian Mandrup}]
  s.date = %q{2011-05-23}
  s.description = %q{Works with geo_calc and other geo libraries}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.textile"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Distance calc notes.txt",
    "Gemfile",
    "LICENSE.txt",
    "README.textile",
    "Rakefile",
    "VERSION",
    "lib/geo_vectors.rb",
    "lib/geo_vectors/bearing_vector.rb",
    "lib/geo_vectors/core_ext.rb",
    "lib/geo_vectors/direction_vector.rb",
    "lib/geo_vectors/geo_point.rb",
    "lib/geo_vectors/geo_vector.rb",
    "lib/geo_vectors/geo_vectors.rb",
    "lib/geo_vectors/point_vector.rb",
    "lib/geo_vectors/point_vector/point_ops.rb",
    "lib/geo_vectors/point_vector/vector_ops.rb",
    "lib/geo_vectors/util.rb",
    "lib/geo_vectors/util/calc.rb",
    "lib/geo_vectors/util/geo_direction.rb",
    "lib/geo_vectors/util/geo_distance.rb",
    "lib/geo_vectors/util/geo_units.rb",
    "lib/geo_vectors/vector_parser.rb",
    "spec/geo_vectors/API proposal guide.txt",
    "spec/geo_vectors/bearing_vector/add_vector_spec.rb",
    "spec/geo_vectors/bearing_vector/random_spec.rb",
    "spec/geo_vectors/bearing_vector_spec.rb",
    "spec/geo_vectors/direction_vector/add_vector_spec.rb",
    "spec/geo_vectors/direction_vector/point_add_spec.rb",
    "spec/geo_vectors/direction_vector/random_spec.rb",
    "spec/geo_vectors/direction_vector/subtract_vector_spec.rb",
    "spec/geo_vectors/direction_vector_spec.rb",
    "spec/geo_vectors/geo_vectors_spec.rb",
    "spec/geo_vectors/point_vector/add_vector_spec.rb",
    "spec/geo_vectors/point_vector/initializer_spec.rb",
    "spec/geo_vectors/point_vector/point_add_spec.rb",
    "spec/geo_vectors/point_vector/random_spec.rb",
    "spec/geo_vectors/point_vector/scale_vector_spec.rb",
    "spec/geo_vectors/point_vector/subtract_vector_spec.rb",
    "spec/geo_vectors/point_vector_spec.rb",
    "spec/geo_vectors/util/geo_direction_spec.rb",
    "spec/geo_vectors/util/geo_distance_spec.rb",
    "spec/geo_vectors/util/geo_units_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/geo_vectors}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.0}
  s.summary = %q{Geo vector library for applying vectors to GeoPoints and for basic vector math}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<geo_calc>, [">= 0.5.4"])
      s.add_runtime_dependency(%q<proxy_party>, [">= 0.2.1"])
      s.add_runtime_dependency(%q<sugar-high>, [">= 0.4.1"])
      s.add_development_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.6.0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<proxy_party>, [">= 0.2.1"])
      s.add_runtime_dependency(%q<sugar-high>, [">= 0.4.1"])
      s.add_runtime_dependency(%q<geo_calc>, [">= 0.5.4"])
      s.add_development_dependency(%q<rspec>, [">= 2.5.0"])
    else
      s.add_dependency(%q<geo_calc>, [">= 0.5.4"])
      s.add_dependency(%q<proxy_party>, [">= 0.2.1"])
      s.add_dependency(%q<sugar-high>, [">= 0.4.1"])
      s.add_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, [">= 1.6.0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<proxy_party>, [">= 0.2.1"])
      s.add_dependency(%q<sugar-high>, [">= 0.4.1"])
      s.add_dependency(%q<geo_calc>, [">= 0.5.4"])
      s.add_dependency(%q<rspec>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<geo_calc>, [">= 0.5.4"])
    s.add_dependency(%q<proxy_party>, [">= 0.2.1"])
    s.add_dependency(%q<sugar-high>, [">= 0.4.1"])
    s.add_dependency(%q<rspec>, [">= 2.3.0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, [">= 1.6.0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<proxy_party>, [">= 0.2.1"])
    s.add_dependency(%q<sugar-high>, [">= 0.4.1"])
    s.add_dependency(%q<geo_calc>, [">= 0.5.4"])
    s.add_dependency(%q<rspec>, [">= 2.5.0"])
  end
end

