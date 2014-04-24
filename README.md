```
bundle exec cap install
edit Capfile
bundle exec rails generate rspec:install
rm -rf test
bundle exec guard init
mkdir lib/capistrano/templates
cd ./lib/capistrano/templates
vi database_yml.erb
vi nginx_conf.erb
vi nginx_site.erb
vi unicorn_init.erb
vi unicorn.rb.erb
cd ./lib/capistrano/tasks
vi nginx_unicorn.cap
vi utility.cap
cd ./config
vi deploy.rb
cd ./config/deploy
vi production.rb
vi staging.rb
set :ssh_options, {keys: %w(/Users/onesup/.ssh/ids/hug.mnv.kr/deployer/id_rsa)}
cd ./
vi .gitignore
```
```
페북 로그인 코드: http://www.maxgillett.com/post/28504483668/devise-omniauth-facebook-js-sdk-tutorial
```
```
cat cert_hug.mnv.kr.crt subca1_hug.mnv.kr.crt rootca_hug.mnv.kr.crt > hug.mnv.kr.chained.crt
```
```
ie iframe 관련
{"error":{"message":"This authorization code has expired.","type":"OAuthException","code":100}}
https://github.com/carrot/p3p
```
```
http://android.stackexchange.com/questions/5999/android-browsers-aboutdebug-what-do-those-settings-do
```