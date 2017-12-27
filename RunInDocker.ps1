docker run --volume="$PWD":/srv/jekyll --name jekyll_robgrzel.github.io `
-it -p 4000:4000 -e JEKYLL_ENV=dev jekyll/jekyll:pages `
jekyll s --config _config.yml,_config.dev.yml --force_polling