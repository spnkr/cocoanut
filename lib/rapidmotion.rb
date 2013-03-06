unless defined?(Motion::Project::Config)
  raise "The rapidmotion gem must be required within a RubyMotion project Rakefile."
end


Motion::Project::App.setup do |app|
  insert_point = 0
  app.files.each_index do |index|
    file = app.files[index]
    if file =~ /^(?:\.\/)?app\//
      # found app/, so stop looking
      break
    end
    insert_point = index + 1
  end

  Dir.glob(File.join(File.dirname(__FILE__), 'rapidmotion/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
end
