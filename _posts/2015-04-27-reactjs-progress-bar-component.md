---
layout: post
title: "ReactJs progress bar component and wrap it in an Angular directive"
description: ""
category:
tags: [javascript, reactjs, angularjs]
---

[Not finished yet]

We will start with a gulp angular seeded project. Why an angular project? Because currently my team is using angular

#1. Create the scaffold

`yo gulp-angular`

> If you get the following error message: `You don't seem to have a generator with the name gulp-angular installed`, install the generator first with `npm install -g generator-gulp-angular` (note the `generator-` part). Again if you get another error: `The package express does not satisfy its siblings' peerDependencies requirements!`, replace `-g` with `-G`. I got it when I install with Gitbash on Windows, and haven't verified on other operating systems. More information, please find this [SO question](http://stackoverflow.com/questions/22493299/yeoman-angular-generator-install-runs-but-generator-doesnt-appear-in-generator). The error is not exactly the same by the way.


> I chose Angular version 1.3.x, with no jQuery, no REST library ($http is enough), with UI Router, Bootstrap, Sass.

After generated the code, run

`gulp serve`

#2. Inject react.js

`bower install react --save`

Now you have `react.js` on your home page.

#3. Reactify JSX files

`npm install reactify --save-dev`