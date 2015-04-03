---
layout: post
title: "Build Nanki (1)"
description: ""
category: Tech
tags: [tech, nanki]
---

# Build Nanki Part I
First, let's design the User's Journey in the Nanki App. As an impatient developer, why not copy some beautiful thing
from others. The user experience of Mailbox is superb. Let's see if we can achieve it with html, css and javascript.


We are going to build it with `angularjs`, so in the `mailBox.html` file, we declare it at the html tag as
`<html ng-app="mail">`<sup>1</sup>.

> 1. ng-app can be put anywhere, e.g. `<body ng-app="mail">`, as long as all the related directives are its decedeants.

Since we are going to use it on a mobile phone, add the following line to `<head>` section.

{% highlight html %}
<meta name="viewport" content="initial-scale = 1.0,maximum-scale = 1.0"/>
{% endhighlight %}

Add controller to body tag: `<body ng-controller="MailController">`

## Html Layout

The body will be divided into 4 parts:

{% highlight html %}
<div class="wrapper">
    <header class="clearfix"> ...
    <section class="search-bar"> ...
    <section class="container"> ...
    <footer class="clearfix"> ...
</div>
{% endhighlight %}

We will go through them one by one.

### header

{% highlight html %}
<header class="clearfix">
    <i class="menu icon-reorder"></i>
    <ul class="button-group">
        <li class="later icon-time"></li>
        <li class="inbox icon-inbox"></li>
        <li class="archive icon-ok"></li>
    </ul>
    <i class="edit icon-edit"></i>
</header>
{% endhighlight %}

#### clearfix

`clearfix` is used to fix the floating 'issue'. We use `float` to move the 'menu' icon to the left and 'edit' icon to the
right. The same tech is used for the footer.

> [http://stackoverflow.com/questions/8554043/what-is-clearfix] .`float` is meant to do stuff like float images next to
> long runs of text, but lots of people used it as their primary layout mechanism.

`clearfix` will add an element after and set `clear: both` for that element.

The content of `clearfix` as (scss or css) is:

{% highlight scss %}
.clearfix {
  *zoom: 1;
  &:before,&:after{
    display: table;
    line-height: 0;
    content: "";
  }
  &:after{
    clear: both;
  }
}
{% endhighlight %}

or

{% highlight scss %}
.clearfix {
  *zoom: 1;
}
.clearfix:before, .clearfix:after {
  display: table;
  line-height: 0;
  content: "";
}
.clearfix:after {
  clear: both;
}
{% endhighlight %}

#### icon-xxx

We use FontAwsome in this project. The class name `icon-xxx` can be put inside any tag.

Make sure the following line is added to the html file:

{% highlight html %}
<link charset='utf-8' href='css/font-awesome.css' rel='stylesheet' type='text/css'/>
{% endhighlight %}


<ul>
<li id="section-5">
            <div class="annotation">

              <div class="pilwrap ">
                <a class="pilcrow" href="#section-5">&#182;</a>
              </div>
              <p>buttons inside the group</p>

            </div>

            <div class="content"><div class='highlight'><pre>    <span class="tag">li</span> {
      <span class="attribute">font-size</span><span class="value">: <span class="number">16</span>px;</span>
      <span class="attribute">display</span><span class="value">: inline-block;</span>
      <span class="attribute">padding</span><span class="value">: <span class="number">5</span>px <span class="number">20</span>px;</span></pre></div></div>

        </li>
        <li id="section-6">
            <div class="annotation">

              <div class="pilwrap ">
                <a class="pilcrow" href="#section-6">&#182;</a>
              </div>
              <p>Add left border for each icon and remove the left border for the first icon late.</p>

            </div>

            <div class="content"><div class='highlight'><pre>      <span class="attribute">border-left</span><span class="value">: $header-icon-border;</span>
    }

    <span class="pseudo">:first-child</span>{
      <span class="attribute">border-left</span><span class="value">: none;</span>
    }
  }

}</pre></div></div>
</li>

</ul>

![Alt text](/assets/images/mailbox.png)
