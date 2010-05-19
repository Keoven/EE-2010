String.class_eval do
  ## Based upon http://www.giantjapaneserobot.com/post/191116276/ruby-on-rails-string-to-boolean
  #
  def to_bool
    return ['true', '1', 'T', 't'].include? self
  end
end

namespace 'gh' do
  desc 'Update Local and GitHub Repository (rake gh:u[<String>,<Optional Boolean>])'
  task :u, [:msg, :push_only?] do |t, args|
    args.with_defaults(:msg => '', :push_only? => 'false')
    if args.msg.empty? and !push_only?
      puts 'Please supply message for update.'
    else
      Rake::Task['gh:c'].invoke(args.msg) unless args.push_only?.to_bool
      Rake::Task['gh:ps'].invoke
    end
  end

  desc 'Push to GitHub Repository Only'
  task :ps do
    puts '==Updating GitHub Repository====================='
    %x{ git push origin master }
    puts '==Updating GitHub Repository: Finished==========='
  end

  desc 'Commit Changes to Local Repository (rake gh:c[<String>])'
  task :c, [:msg] do |t, args|
    args.with_defaults(:msg => '')
    if args.msg.empty?
      puts 'Please supply message for update.'
    else
      puts '==Updating Local Repository========================'
      %x{ git add .
          git commit -am '#{args.msg}'
          git pull origin master }
      puts '==Updating Local Repository: Finished=============='
    end
  end

  desc 'Pull from GitHub Repository Only'
  task :pl do
    puts '==Updating Local Repository========================'
    %x{ git pull origin master }
    puts '==Updating Local Repository: Finished=============='
  end
end

