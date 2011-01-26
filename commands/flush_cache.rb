require 'ruble'

# Delete all the cache.yml files in the bundles. They'll be re-generated
# on next restart.
command "Flush Bundle Caches" do |cmd|
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.invoke do
    str = ""
    
    bundle_manager = Ruble::BundleManager.manager
    bundles_dir = bundle_manager.getUserBundlesPath
    Dir.chdir(bundles_dir)  # Go to bundles root dir
    Dir.glob("*.ruble").each do |filename|
      bundle_dir = File.join(bundles_dir, filename)
      bundle_dir = File.readlink(bundle_dir) if File.symlink?(bundle_dir)
      Dir.chdir(bundle_dir) do |dir|
        cache_file = File.join(Dir.pwd, 'cache.yml')
        begin
          File.delete(cache_file)
          str << "Deleted: #{cache_file}\n"
        rescue
          # ignore?
        end
      end
    end
    str
  end
end