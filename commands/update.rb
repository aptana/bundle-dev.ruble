require 'ruble'
require 'ruble/progress'

# This command luanches a job to update the bundle async, so we don't block the IDE.
# We provide progress in the job as we go on the IProgressMonitor
# We also spit out the resulting output of the operations to the scripting console
command "Update User Bundles" do |cmd|
  cmd.input = :none
  cmd.output = :discard
  cmd.invoke do |context|
    job = Ruble::Job.new("Updating user bundles...") do |monitor|
      initial_log_level = Ruble::Logger.log_level
      Ruble::Logger.log_level = :info

      git_path = com.aptana.git.core.model.GitExecutable.instance.path.toOSString
      bundle_manager = Ruble::BundleManager.manager
      bundles_dir = bundle_manager.getUserBundlesPath
      Dir.chdir(bundles_dir)  # Go to bundles root dir
      ruble_dirs = Dir.glob("*.ruble")

      unless monitor.isCanceled
        monitor.beginTask("Updating rubles", ruble_dirs.size)

        ruble_dirs.each do |filename|
          next if monitor.isCanceled

          monitor.subTask("Updating #{filename}")
          bundle_dir = File.join(bundles_dir, filename)
          bundle_dir = File.readlink(bundle_dir) if File.symlink?(bundle_dir)
          Dir.chdir(bundle_dir) do |dir|
            log_info "#{dir.to_s}:"
            if File.exists?(File.join(dir, ".git"))
              output = IO.popen("#{git_path} pull 2>&1", 'r') {|io| io.read }.chomp
              $?.exitstatus == 0 ? log_info(output) : log_error(output)
            elsif File.exists?(File.join(dir, ".svn"))
              output = IO.popen("svn update 2>&1", 'r') {|io| io.read }.chomp
              $?.exitstatus == 0 ? log_info(output) : log_error(output)
            end
            log_info "--------------------------------------------------------------"
          end
          monitor.worked(1)
        end
      end
      Ruble::Logger.log_level = initial_log_level
    end
    job.setUser(true)
    job.schedule
    nil
  end
end