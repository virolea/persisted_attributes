require_relative "lib/persisted_attributes/version"

Gem::Specification.new do |spec|
  spec.name        = "persisted_attributes"
  spec.version     = PersistedAttributes::VERSION
  spec.authors     = ["Vincent Rolea"]
  spec.email       = ["3525369+virolea@users.noreply.github.com"]
  spec.homepage    = "https://github.com/virolea/dynamic_fields"
  spec.summary     = "Add persisted fields to active record models without migrations."
  spec.description = "Add persisted fields to active record models without migrations."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.3.4"
end
