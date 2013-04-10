task :install => [:npm]
task :build => [:stopService, :npm, :startService]
task :default => [:runProgram]


task :npm do
    sh "echo downfall | sudo -S npm install"
end

task :stopService do
    sh "echo downfall | sudo -S service worker-kue stop"
end

task :startService do
    sh "echo downfall | sudo -S service worker-kue start"
end

task :runProgram do
  sh "node index.js"
end





