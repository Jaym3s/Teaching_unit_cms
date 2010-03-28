# DO NOT MODIFY THIS FILE

require 'digest/sha1'
require 'rubygems'

module Gem
  class Dependency
    if !instance_methods.map { |m| m.to_s }.include?("requirement")
      def requirement
        version_requirements
      end
    end
  end
end

module Bundler
  module SharedHelpers

    def default_gemfile
      gemfile = find_gemfile
      gemfile or raise GemfileNotFound, "The default Gemfile was not found"
      Pathname.new(gemfile)
    end

    def in_bundle?
      find_gemfile
    end

  private

    def find_gemfile
      return ENV['BUNDLE_GEMFILE'] if ENV['BUNDLE_GEMFILE']

      previous = nil
      current  = File.expand_path(Dir.pwd)

      until !File.directory?(current) || current == previous
        filename = File.join(current, 'Gemfile')
        return filename if File.file?(filename)
        current, previous = File.expand_path("..", current), current
      end
    end

    def clean_load_path
      # handle 1.9 where system gems are always on the load path
      if defined?(::Gem)
        me = File.expand_path("../../", __FILE__)
        $LOAD_PATH.reject! do |p|
          next if File.expand_path(p).include?(me)
          p != File.dirname(__FILE__) &&
            Gem.path.any? { |gp| p.include?(gp) }
        end
        $LOAD_PATH.uniq!
      end
    end

    def reverse_rubygems_kernel_mixin
      # Disable rubygems' gem activation system
      ::Kernel.class_eval do
        if private_method_defined?(:gem_original_require)
          alias rubygems_require require
          alias require gem_original_require
        end

        undef gem
      end
    end

    def cripple_rubygems(specs)
      reverse_rubygems_kernel_mixin

      executables = specs.map { |s| s.executables }.flatten

     :: Kernel.class_eval do
        private
        def gem(*) ; end
      end
      Gem.source_index # ensure RubyGems is fully loaded

      ::Kernel.send(:define_method, :gem) do |dep, *reqs|
        if executables.include? File.basename(caller.first.split(':').first)
          return
        end
        opts = reqs.last.is_a?(Hash) ? reqs.pop : {}

        unless dep.respond_to?(:name) && dep.respond_to?(:requirement)
          dep = Gem::Dependency.new(dep, reqs)
        end

        spec = specs.find  { |s| s.name == dep.name }

        if spec.nil?
          e = Gem::LoadError.new "#{dep.name} is not part of the bundle. Add it to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        elsif dep !~ spec
          e = Gem::LoadError.new "can't activate #{dep}, already activated #{spec.full_name}. " \
                                 "Make sure all dependencies are added to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        end

        true
      end

      # === Following hacks are to improve on the generated bin wrappers ===

      # Yeah, talk about a hack
      source_index_class = (class << Gem::SourceIndex ; self ; end)
      source_index_class.send(:define_method, :from_gems_in) do |*args|
        source_index = Gem::SourceIndex.new
        source_index.spec_dirs = *args
        source_index.add_specs(*specs)
        source_index
      end

      # OMG more hacks
      gem_class = (class << Gem ; self ; end)
      gem_class.send(:define_method, :bin_path) do |name, *args|
        exec_name, *reqs = args

        spec = nil

        if exec_name
          spec = specs.find { |s| s.executables.include?(exec_name) }
          spec or raise Gem::Exception, "can't find executable #{exec_name}"
        else
          spec = specs.find  { |s| s.name == name }
          exec_name = spec.default_executable or raise Gem::Exception, "no default executable for #{spec.full_name}"
        end

        gem_bin = File.join(spec.full_gem_path, spec.bindir, exec_name)
        gem_from_path_bin = File.join(File.dirname(spec.loaded_from), spec.bindir, exec_name)
        File.exist?(gem_bin) ? gem_bin : gem_from_path_bin
      end
    end

    extend self
  end
end

module Bundler
  LOCKED_BY    = '0.9.13'
  FINGERPRINT  = "f6174adc0533c9c9062eeb6e092bb8a27eb1da47"
  AUTOREQUIRES = {:default=>[["acts-as-taggable-on", false], ["aws-s3", false], ["haml", false], ["paperclip", false], ["rails", false], ["rspec-rails", false], ["sqlite3-ruby", false], ["thin", false], ["will_paginate", false]]}
  SPECS        = [
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rake-0.8.7/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rake-0.8.7.gemspec", :name=>"rake"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/activesupport-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/activesupport-2.3.5.gemspec", :name=>"activesupport"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rack-1.0.1/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rack-1.0.1.gemspec", :name=>"rack"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/actionpack-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/actionpack-2.3.5.gemspec", :name=>"actionpack"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/actionmailer-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/actionmailer-2.3.5.gemspec", :name=>"actionmailer"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/activerecord-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/activerecord-2.3.5.gemspec", :name=>"activerecord"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/activeresource-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/activeresource-2.3.5.gemspec", :name=>"activeresource"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/acts-as-taggable-on-1.1.9/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/acts-as-taggable-on-1.1.9.gemspec", :name=>"acts-as-taggable-on"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/builder-2.1.2/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/builder-2.1.2.gemspec", :name=>"builder"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/mime-types-1.16/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/mime-types-1.16.gemspec", :name=>"mime-types"},
        {:load_paths=>["/Users/jaymes/.bundle/ruby/1.8/gems/xml-simple-1.0.12/lib"], :loaded_from=>"/Users/jaymes/.bundle/ruby/1.8/specifications/xml-simple-1.0.12.gemspec", :name=>"xml-simple"},
        {:load_paths=>["/Users/jaymes/.bundle/ruby/1.8/gems/aws-s3-0.6.2/lib"], :loaded_from=>"/Users/jaymes/.bundle/ruby/1.8/specifications/aws-s3-0.6.2.gemspec", :name=>"aws-s3"},
        {:load_paths=>["/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib"], :loaded_from=>"/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8/specifications/daemons-1.0.10.gemspec", :name=>"daemons"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/eventmachine-0.12.10/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/eventmachine-0.12.10.gemspec", :name=>"eventmachine"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/haml-2.2.22/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/haml-2.2.22.gemspec", :name=>"haml"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/paperclip-2.3.1.1/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/paperclip-2.3.1.1.gemspec", :name=>"paperclip"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rails-2.3.5/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rails-2.3.5.gemspec", :name=>"rails"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rspec-1.3.0/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rspec-1.3.0.gemspec", :name=>"rspec"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/rspec-rails-1.3.2/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/rspec-rails-1.3.2.gemspec", :name=>"rspec-rails"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/sqlite3-ruby-1.2.5/lib", "/Library/Ruby/Gems/1.8/gems/sqlite3-ruby-1.2.5/ext"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/sqlite3-ruby-1.2.5.gemspec", :name=>"sqlite3-ruby"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/thin-1.2.7/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/thin-1.2.7.gemspec", :name=>"thin"},
        {:load_paths=>["/Library/Ruby/Gems/1.8/gems/will_paginate-2.3.12/lib"], :loaded_from=>"/Library/Ruby/Gems/1.8/specifications/will_paginate-2.3.12.gemspec", :name=>"will_paginate"},
      ].map do |hash|
    if hash[:virtual_spec]
      spec = eval(hash[:virtual_spec], binding, "<virtual spec for '#{hash[:name]}'>")
    else
      dir = File.dirname(hash[:loaded_from])
      spec = Dir.chdir(dir){ eval(File.read(hash[:loaded_from]), binding, hash[:loaded_from]) }
    end
    spec.loaded_from = hash[:loaded_from]
    spec.require_paths = hash[:load_paths]
    spec
  end

  extend SharedHelpers

  def self.configure_gem_path_and_home(specs)
    # Fix paths, so that Gem.source_index and such will work
    paths = specs.map{|s| s.installation_path }
    paths.flatten!; paths.compact!; paths.uniq!; paths.reject!{|p| p.empty? }
    ENV['GEM_PATH'] = paths.join(File::PATH_SEPARATOR)
    ENV['GEM_HOME'] = paths.first
    Gem.clear_paths
  end

  def self.match_fingerprint
    print = Digest::SHA1.hexdigest(File.read(File.expand_path('../../Gemfile', __FILE__)))
    unless print == FINGERPRINT
      abort 'Gemfile changed since you last locked. Please `bundle lock` to relock.'
    end
  end

  def self.setup(*groups)
    match_fingerprint
    clean_load_path
    cripple_rubygems(SPECS)
    configure_gem_path_and_home(SPECS)
    SPECS.each do |spec|
      Gem.loaded_specs[spec.name] = spec
      $LOAD_PATH.unshift(*spec.require_paths)
    end
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      (AUTOREQUIRES[group.to_sym] || []).each do |file, explicit|
        if explicit
          Kernel.require file
        else
          begin
            Kernel.require file
          rescue LoadError
          end
        end
      end
    end
  end

  # Setup bundle when it's required.
  setup
end
