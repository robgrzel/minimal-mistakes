#JEKYLL_ENV=development make it crash,
docker run --volume="$PWD":/srv/jekyll --name jekyll_robgrzel.github.io `
-it -p 127.0.0.1:4000:4000 -e JEKYLL_ENV=docker jekyll/jekyll:latest `
jekyll s --config _config.yml,_config.dev.yml --force_polling --incrementall