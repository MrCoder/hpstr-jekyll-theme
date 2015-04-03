---
layout: post
title: "Understanding Require In NodeJs"
description: ""
category: 
tags: []
---

# Understanding Require in NodeJs

**`require` in NodeJs is very different from the client-side library `RequireJs`**. The latter will not be covered in this post.

`require` is an implementation in NodeJs to support moduling following CommonJs specfication.

`require` works like `include` (in C++) or `import` (in Java) things. The basic functionanlity of `require` is that it **reads a javascript file, executes the file and proceeds to return the `exports` object**.

An example of a `require`d file:

    console.log('evaluating example.js');
    exports.message = 'hello world';

If you run `var example=require('./example.js')`, we will see `evaluating example.js` on the console, and example be an object equal to:

    {
        message: "hello world"
    }

However, you shold not change the reference of `exports`. An error example:

    console.log('Hello Error world');
    // exports will NOT be returned.
    exports = function Error(){};

Your code can be view in this way:

    var module = { exports: {} };
    var exports = module.exports;
    // Your code
    return module.exports;

`module` is a plain Javascript object. If you change `exports` by `exprots = another_object` or `exports = a_function`, you will lose it (`module.exports` will not be changed after the reference of `exports` is changed.)

Some other points you should know about `require`:

* `require`d `exports` is cached.
* you can omit `.js` and `require` will automatically append it if needed.
* If the file doesn't start with "./" or "/", then it is consided as either a core module or located in local `node_modules` folder.
* If the file stars with "./", it is considered a relative file to the file that called `require`.
* If the file starts with "/", it is consided an absolute path.
* If the file-name is actually a directory, it will first look for `package.json` and load the file referenced in the `main` property; otherwise, it will look for an `index.js`.

References:

1. http://docs.nodejitsu.com/articles/getting-started/what-is-require
1. http://stackoverflow.com/questions/16383795/difference-between-module-exports-and-exports-in-the-commonjs-module-system/16383925?noredirect=1#16383925