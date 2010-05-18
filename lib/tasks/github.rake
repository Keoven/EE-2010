String.class_eval do
  # Based upon http://www.giantjapaneserobot.com/post/191116276/ruby-on-rails-string-to-boolean
  #
  def to_bool
    return ['true', '1', 'T', 't'].include? self
  end
end

namespace 'ghub' do
  desc 'Update GitHub Repository (rake ghub:push[<String>,<Optional Boolean>])'
  task :push, [:msg, :push_only?] do |t, args|
    args.with_defaults(:msg => '', :push_only? => 'false')
    if args.msg.empty?
      puts 'Please supply message for update.'
    else
      Rake::Task['ghub:pull'].invoke unless args.push_only?.to_bool
      puts '==Updating GitHub Repository====================='
      %x{ git add .
          git commit -am '#{args.msg}'
          git push origin master }
      puts '==Updating GitHub Repository: Success============'
    end
  end

  desc 'Update GitHub Repository w/o Pulling (rake ghub:posh[<String>])'
  task :posh, [:msg] do |t, args|
    Rake::Task['ghub:push'].invoke(args.msg, 'true')
  end

  desc 'Update Local Repository'
  task :pull do
    puts '==Updating Local Repository========================'
    %x{ git pull origin master }
    puts '==Updating Local Repository: Success==============='
  end
end

