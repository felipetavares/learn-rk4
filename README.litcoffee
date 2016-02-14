# About

Welcome to *Learn RK4*!

Here we implement a very small and straight-forward RK4 integrator.

In our example, we are solving the motion of an harmonic oscillator.

This is written in [Literate CoffeeScript](http://coffeescript.org/#literate), so you can just clone the repo and execute with `coffee README.litcoffee`.

Have fun!

# Solver

## Velocity

This function returns the velocity of the oscillator, given the time and current position (which is not used in this example).

Why do we need the velocity of the oscillator? Because RK4 works with *derivatives*. If you want the position, you use the positions' derivative, which is velocity. If you wanted velocity, you would go with acceleration.

`a` is for amplitude, `w` is for angular speed.

In this case, `w` is calculated for one oscillation per
time unit (seconds in our example).

    v = (t, y) ->
      w = 2*Math.PI
      a = 5

      -a*w*Math.sin(w*t)

## RK4

This is the main RK4 solver.

Input:

  * Current time
  * Current value (position)
  * Delta time (time increment)

Output:

  * New value (position)

This is the core logic:

    rk4 = (t, y, h) ->
      k1 = v(t,       y)
      k2 = v(t + h/2, y + h/2*k1)
      k3 = v(t + h/2, y + h/2*k2)
      k4 = v(t + h,   y + h*k3)

      y + h/6*(k1 + 2*k2 + 2*k3 + k4)

## Loop

Prints an `o` at the current position, which is stored in `y`.

Some initial values (time, position, and time step):

    t = 0
    y = 0
    h = 1/24

Main loop:

    main = ->
      y = rk4 t, y, h

Printing spaces, we add 11 to make sure there will be no negative values:

      for space in [0..(Math.floor y+11)]
        process.stdout.write ' '

      process.stdout.write 'o\n'

      t += h

      setTimeout main, h*1000

A final `setTimeout` to start the loop:

    setTimeout main, h*1000

Yeah! It is **that** easy.

# Stars are falling

Did you find *Learn RK4* useful? Star!
