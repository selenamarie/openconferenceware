set :theme, "bridgepdx"

set :scm, "git"
set :repository,  "git://github.com/igal/openconferenceware.git"
set :branch, "master"
set :deploy_to, "/var/www/bridgepdx_ocw"
set :host, "opensourcebridge.org"

set :deploy_via, :remote_cache
role :app, host
role :web, host
role :db,  host, :primary => true
default_run_options[:pty] = true
