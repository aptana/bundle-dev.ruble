require 'radrails'

bundle 'Bundle Development' do |bundle|
  bundle.author = "Christopher Williams, Andrew Shebanow"
  bundle.copyright = <<END
© Copyright 2010 Aptana Inc. Distributed under GPLv3 and Aptana Source license.
END

  bundle.description = <<END
A quick and dirty bundle to make it easier to update your other bundles. Won't work on Windows unless you use cygwin'
END

  bundle.repository = "git@github.com:aptana/bundle-dev-ruble.git"

  # This command should show regardless of scope, so we don't define one.
  bundle.menu "Bundle Development" do |menu|
    menu.command "Update" do |cmd|
      cmd.input = :none
      cmd.output = :show_as_tooltip
      cmd.invoke do
        str = ""
        bundles_dir = File.expand_path("~/Documents/RadRails Bundles")
        Dir.chdir(bundles_dir)  # Go to bundles root dir
        Dir.glob("*.ruble").each do |filename|
          bundle_dir = File.join(bundles_dir, filename)
          bundle_dir = File.readlink(bundle_dir) if File.symlink?(bundle_dir)
          Dir.chdir(bundle_dir) do |dir|
            IO.popen("git pull", 'r') {|io| str << io.read } if File.exists?(File.join(dir, ".git"))
            IO.popen("svn update", 'r') {|io| str << io.read } if File.exists?(File.join(dir, ".svn"))
          end
        end
        str
      end
    end
  end
end

