docker run --rm --volume="$PWD":/srv/jekyll -it -p 4000:4000 `
--name jekyll_robgrzel.github.io -e JEKYLL_ENV=dev `
jekyll/jekyll jekyll s --config _config.yml,_config.dev.yml --force_polling