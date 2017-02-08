# Shooter31
Simple Shooter game
Assignment 2 for OOP Year 2
_(Note: done in 2 days)_

Demo:

[![Video](http://img.youtube.com/vi/MVEIl_0h0GU/0.jpg)](https://www.youtube.com/watch?v=MVEIl_0h0GU)

I have tried using as many different concepts as possible to learn more.
Some of the classes I used are:
* PImage
* PVector
* FloatList
* ArrayList
* PShape
* Abstract classes
Some of the other things I used:
* pushMatrix() and popMatrix()
* translate()
* rotate()
* P3D
* Multiple screens
* Powerups
* Inheritance
* Polymorphism
* Transforms
* Image files

Shooter31 consists of:
* The Ship
  * Moves using Arrow keys
  * Has a health bar represented as an arc
  * Can fire bullets at 3 bullets per second
    * Space: Fires normal bullets
    * z: Fires 360 degree bullet - should have an energy bar
    * x: Fires 1 super bullet which takes time to charge
* The Background
  * Stars in background with various distance- represented as fainter stars
  * Stars have a flickering effect
* The camera
  * Follows ship
  * Can zoom out or in using scroll
* Enemies
  * Various sizes - attack ship and fire at it. They aim!
  * Different colors
  * Health written in the center
* Score
  * Depends on damage produced, not enemies killed
  * Always at the top
* Game Over Screen
  * When you lose
    * Enemies disapear
    * Score is there for you to see
    * When 'R' pressed, game resets

General Game Mechanics:
* Difficulty
* Number of enemies increase over time, making the game harder if you dont kill enemies ASAP


# Have Fun Playing! :)
