---
layout: post
title: "Comparing Scala with JavaScript"
description: ""
category: 
tags: []
---


# Comparing Function Value Reference in Scala and JavaScript

The functional programming flavor in Scala is very simimliar to that of JavaScript. Let's compare the following code:

    // Javascript code, can be found here: http://codepen.io/MrCoder/pen/bcKLF
    function filter_odd(i){
      return i % 2 === 0 ? 0 : i;
    }

    function filter_even(i){
      return i % 2 === 0 ? i : 0;
    }

    function total(max, filter){
      var result = 0;
      for (var i = 0; i < max; i++){
        result += filter(i);
      }
      return result;
    }

    console.log(total(100, filter_odd));
    console.log(total(100, filter_even));

Then let's have a look at Scala implemenation:

    def filter_odd(i: Int) = {if (i%2 == 0) 0 else i}
    def filter_even(i: Int) = {if (i%2 == 0) i else 0}

    def total(max: Int, filter: Int => Int) = {
        var result = 0
        for(i <- 1 to max){
          result += filter(i)
        }
        result
    }

    println(total(100, filter_odd))
    println(total(100, filter_even))

What makes it even more interesting is that both of them have a second style for the filter_xxx

    // JavaScript. Can be found here: http://codepen.io/MrCoder/pen/zjGiu
    var filter_odd = function(i){
      return i % 2 === 0 ? 0 : i;
    }

    var filter_even = function(i){
      return i % 2 === 0 ? i : 0;
    }

And Scala version:

    val filter_even = {(i: Int) => if (i%2 == 0) i else 0}
    var filter_odd = {(i: Int) => if (i%2 == 0) 0 else i}

