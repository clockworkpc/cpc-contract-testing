require 'pry'
require 'fileutils'

class ProjectRenamer

  def initialize
    @project_details_path = 'bin/project_details.json'
    project_details_hsh = JSON.parse(File.read(@project_details_path))
    @old_module_str = project_details_hsh["module"]
    @old_spec_str = project_details_hsh["spec"]
    @new_module_str = 'Contractor'
    @new_spec_str = 'contractor'
  end

  def grep_spec_module
    grep_ary = `grep -rnw -e "#{@old_module_str}\\|#{@old_spec_str}"`.split("\n")
    grep = grep_ary.map {|x| x.split(':').first unless x.match?(".git")}.compact.uniq
    grep.reject {|k| File.basename(k).eql?("project_details.json")}
  end

  def find_spec_basenames
    Dir["**/**"].select {|n| File.file?(n) && File.basename(n).match?(@old_spec_str) }
  end

  def find_spec_dirs
    Dir["**/**"].select {|n| File.directory?(n) && n.match?(@old_spec_str) }
  end

  def rename_module_and_spec
    path_ary = grep_spec_module
    path_ary.each do |path|
      r = File.read(path)
      w = r.gsub(@old_module_str, @new_module_str).gsub(@old_spec_str, @new_spec_str)

      f = File.open(path, 'w')
      f.write(w)
      f.close
      puts "Renamed Modules and specs in #{path}"
    end
  end

  def rename_files
    basename_ary = find_spec_basenames
    basename_ary.each do |basename|
      puts basename
      if File.basename(basename).match?(@old_spec_str)
        dirname = File.dirname(basename)
        new_basename = File.basename(basename).sub(@old_spec_str, @new_spec_str)
        new_basename = [dirname, new_basename].join('/')
        puts "#{basename} => #{new_basename}"
        begin
          File.rename(basename, new_basename)
        rescue ExceptionName
          binding.pry
        end
      end
    end
  end

  def rename_dirs
    unless @old_module_str.eql?(@new_module_str)
      running = true
      while running
        dir_ary = find_spec_dirs
        break if dir_ary.empty?
        dir = dir_ary.first
        new_dir = dir.gsub(@old_spec_str, @new_spec_str)
        unless dir.eql?(new_dir)
          puts "#{dir} => #{new_dir}"
          FileUtils.mv(dir, new_dir)
        end
      end
    end
  end

  def rename_project_details
    r = File.read(@project_details_path)
    w = r.gsub(@old_module_str, @new_module_str).gsub(@old_spec_str, @new_spec_str)

    f = File.open(@project_details_path, 'w')
    f.write(w)
    f.close
  end

  def rename_project
    rename_module_and_spec
    sleep 0.1
    rename_files
    sleep 0.1
    rename_dirs
    sleep 0.1
    rename_project_details
  end
end

r = ProjectRenamer.new
r.rename_project
