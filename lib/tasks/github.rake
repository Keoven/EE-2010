namespace 'ghub' do
  desc 'Update GitHub Repository (rake ghub:push[<String>])'
  task :push, [:msg] do |t, args|
    if args.msg.nil?
      puts 'Please supply message for update.'
    else
      Rake::Task['ghub:pull'].invoke
      puts '==Updating GitHub Repository====================='
      %x{ git add .
          git commit -am '#{args.msg}'
          git push origin master }
      puts '==Updating GitHub Repository: Success============'
    end
  end

  desc 'Update Local Repository'
  task :pull do 
    puts '==Updating Local Repository========================'
    %x{ git pull origin master }
    puts '==Updating Local Repository: Success==============='
  end
end
