---
layout: post
title: "Stop mocking, start newing"
description: ""
category:
tags: []
---

The substantial problem of mocking is that when you set up the dependencies with mock, you are assuming an implementation, because you know that the mocked method will be called.

Martin Fowler, Kent Beck and David Heinemeier Hansson had [a hangout talking about TDD](http://martinfowler.com/articles/is-tdd-dead/), in which all three expressed their concerns around mocking from different angles. The videos last for more than one hour so here is [the text version](https://github.com/hedgeyedev/public_wiki/wiki/Is-TDD-Dead ) if you prefer. The hangout is not just about mocking. So I have attempted to summarise their concerns or comments on mocking below (extracted from the text version):

* David Heinemeier Hansson does not agree with “isolated unit testing” because there tend to be “lots of mocks”.
* Kent Beck doesn’t mock very much; implies it’s a smell of bad design.
* Martin Fowler doesn’t mock much either.

DHH, Kent Beck and Martin Fowler did not use any code example in their hangout. I think some Java code can demonstrate the real problems better.

Let’s use online store as an example. To summarise the business rule, if an Order is shipped to within Australia, free shipping is applied, otherwise no free shipping.

Here is our test code:

{% highlight java %}
@Test
public void free_shipping_applies_on_orders_shipped_within_australia(){
    Country mockedCountry = mock(Country.class);
    when(mockedCountry.getName()).thenReturn("Australia");

    Order order = new Order(mockedCountry, other, parameters);
    assertThat(order.freeShipping(), isTrue());
}
{% endhighlight %}

Here is our Order class under test:

{% highlight java %}
public class Order {
    // other methods
    ......
    public boolean freeShipping() {
        return country.getName().equalsIgnoreCase("Australia");
    }
}
{% endhighlight %}

Now we would like to change the way to decide if the country is Australia from comparing Name to comparing Country Code.

{% highlight java %}
public class Order {
    public boolean freeShipping() {
        return country.getCountryCode().equalsIgnoreCase("Au");
    }
}
{% endhighlight %}

The test will fail (throw NullPointerException), because getCountryCode is not mocked. We assumed that we will call getName, but that is an implementation detail. We are not changing the behaviour of the class Order. The test should pass without any change. If real Country object is used, it won't fail. Yes, as you said, we should test contract. But we should test the contracts of the class that is under test, not how the class under test interacts with its dependencies, which is again implementation detail. A paper (www.jmock.org/oopsla2004.pdf ) published in 2004 suggested that we should “mock roles, not objects”. I agree that it is good technique to drive interfaces. It should be limited to that. It should not be used when the dependent classes are already there.

This is an elaborated example, but it does not mean the problems are there in rare cases. It is common and popular. I've seen more teams using Mock in most of the unit tests than not doing that. When they feel the pain of re factoring, they believe that is necessary pain. More teams do not feel the pain, because it has not hurt them that hard.

So I would like to reiterate the problems of mocking:

1. Mocking is unfriendly to refactoring.
The Mock-based test is highly coupled with the implementation.

2. Mocking makes untestable (bad-designed) code look testable and gives fake confidence.
Sometimes, especially when the object is quite complex, mocking an object is easier than creating a real object. That is a design smell(as Kent Beck said). It means your code violates either Single-Responsibility-Principle or Law of Demeter* or, in most cases, both. Before mocking your own classes, re-think if it is easy to create, build and configure. The team may lose an opportunity to verify the design, if they always go with mocking.


* It is easy to understand, that when an object is difficult to create it may have too many dependencies and then tends to violate SRP. Another possible reason is it has a long dependency chain, thus difficult to create. In this case the code violates LoD.