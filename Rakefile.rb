task :install => [:npm]
task :build => [:stopService, :npm, :startService]
task :default => [:runProgram]


task :npm do
    sh "sudo -S npm install"
end

task :stopService do
    sh "sudo -S service which-version-ws stop"
end

task :startService do
    sh "sudo -S service which-version-ws start"
end

task :runProgram do
  sh "node index.js"
end





