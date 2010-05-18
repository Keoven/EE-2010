namespace 'ghub' do
  desc 'Update GitHub Repository (rake ghub:update[<String>])'
  task :push, [:msg] do |t, args|
    if args.msg.nil?
      puts 'Please supply message for update.'
    else
      Rake::Task['ghub:pull'].invoke
      puts 'Updating GitHub Repository'
      %x{ git add .
          git commit -am '#{args.msg}'
          git push origin master }
    end
  end

  desc 'Update Local Repository'
  task :pull do 
    puts 'Updating Local Repository'
    %x{ git pull origin master }
  end
end
