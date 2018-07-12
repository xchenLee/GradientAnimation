# GradientAnimation

### A demo to explore the implementation of the gradient animation
---
It's not real gradient animation, it's just a tricker.

1.Use BezierPath's path to create a rounded rect cycle path
2.Create a shape layer with the path, and set layer's fillRule
3.let the view's mask be the shape layer i created, then the view looks like a cycle, and its content is empty
4.create two view with the same sizes, one fit the view's bounds, another outside the bounds, then animate the two views, repeat forever.

