task :install => [:npm, :createPublicFolder]
task :default => [:runProgram]


task :npm do
    sh "npm install"
end

task :createPublicFolder do
	Dir.chdir("app") do
		Dir::mkdir("public")
	end
end



task :runProgram do
  sh "node index.js"
end





