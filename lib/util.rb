#!/usr/bin/env ruby

require 'fileutils'

def check_repos_txt(check_exist: true)
  FileUtils.mkdir_p 'repos'

  unless File.exists? 'repos.txt'
    STDERR.puts 'ERROR: File not found: repos.txt'
    STDERR.puts ''
    STDERR.puts 'repos.txt should contain a list of Git repo paths like:'
    STDERR.puts '  nicholasdower/foo'
    STDERR.puts '  nicholasdower/bar'
    exit 1
  end

  repos = File.readlines('repos.txt').map(&:strip).reject { |r| r.empty? || r.start_with?('#') }

  if repos.empty?
    STDERR.puts 'ERROR: No repo paths found in: repos.txt'
    STDERR.puts ''
    STDERR.puts 'repos.txt should contain a list of Git repo paths like:'
    STDERR.puts '  nicholasdower/foo'
    STDERR.puts '  nicholasdower/bar'
    exit 1
  end

  if check_exist
    repos.each do |repo|
      dir = "repos/#{repo}"
      unless Dir.exist? dir
        STDERR.puts "ERROR: Directory does not exist: #{dir}"
        exit 1
      end
    end
  end

  found = false

  base_dir = Dir.pwd
  Dir.chdir 'repos'

  Dir.glob('*').select { |f| File.directory? f }.each do |user|
    dirs = Dir.glob("#{user}/*").select { |f| File.directory? f }

    if dirs.empty?
      found = true
      STDERR.puts "ERROR: Encountered unexpected directory: repos/#{user}"
    end

    dirs.each do |dir|
      unless repos.include? dir
        found = true
        STDERR.puts "ERROR: Encountered unexpected directory: repos/#{dir}"
      end
    end
  end

  Dir.chdir base_dir

  exit 1 if found

  repos
end
