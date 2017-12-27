docker run --volume="$PWD":/srv/jekyll --name jekyll_robgrzel.github.io_000 `
-it -p 4001:4001 -e JEKYLL_ENV=development jekyll/jekyll:pages `
jekyll s --config _config.yml,_config.dev.yml --force_polling