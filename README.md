# Dockerimage for running reveal.js with plugins

[![](https://images.microbadger.com/badges/image/blueogive/reveal.js-docker.svg)](https://microbadger.com/images/blueogive/reveal.js-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/blueogive/reveal.js-docker.svg)](https://microbadger.com/images/blueogive/reveal.js-docker "Get your own version badge on microbadger.com")

This images makes it easy to use
[reveal.js](https://github.com/hakimel/reveal.js/) with docker. It supports the
use of the following plugins:

* [MathJax](https://github.com/hakimel/reveal.js/#mathjax) Enables you to write
  LaTeX formulas in your presentations
* [reveal.js-menu](https://github.com/denehyg/reveal.js-menu) Adds a menu to
  test themes, transitions and jump to slides
* [Chalkbord](https://github.com/rajgoel/reveal.js-plugins/tree/master/chalkboard)
  Write on your slides or on a chalkboard
* [Reveal.js-Title-Footer](https://github.com/e-gor/Reveal.js-Title-Footer)
  Adds a footer that will stay on every slide
* [Charts](https://gitlab.com/dvenkatsagar/reveal-chart/) To create charts
  within your presentation
* [vis.js](https://github.com/almende/vis) To create graphs in your
  presentation. This is not a plugin, it just installs vis.js and makes it
  available

## Run the Docker image

The image can be started with:

```
docker run -d --name revealjs \
    -p 9000:8000 \
    -p 35729:35729 \
    -v ./presentations:/revealjs \
    blueogive/reveal.js-docker
```

For easier use I recommend using a `docker-compose.yml` like this:

```
revealjs:
  image: blueogive/reveal.js-docker
  ports:
    - "9000:8000"
    - "35729:35729"
  volumes:
   - ./presentations:/revealjs
```

## Access reveal.js

With the container running, the default presentation is accessible by browsing to `[http://localhost:9000](http://localhost:9000)`. The official reveal.js demo presentation is available at `[http://localhost:9000/demo.html](http://localhost:9000/demo.html)`. A two-slide whiteboard demo is available at `[http://localhost:9000/whiteboard.html](http://localhost:9000/whiteboard.html)`.
