# Fuudo

Check the timelapse out here: https://www.youtube.com/watch?v=PSMF5d3__A4

## The stack

- Swift 5.x
- SwiftUI + Occasional Combine

## Notes / Thoughts

I made sure to include Unit Tests in the fuudoAPI Framework.

## Project Structure

I'm going to primarily be using the MVVM pattern to build out this implementation.  
Unless otherwise specified - the fuudoAPI framework should be thought of as the Model. 

- [See Readme in fuudoAPI package]

It should do all of the heavy lifting of the data and the lighter view models in the app proper should only make light interactions and call into the model for mutation.     

The app will have 3 tabs in a Tab Bar

- dashboard
"One-Stop-Shop" collection of data at a glance that should give the user a glance at what they need, quickly.

- upcoming
A peek at the next days and weeks menu offerings - could theorhetically allow for "pre-buffering" custom orders for a given provider [Stretch Goal].

- profile
    - Allow users to set dietary needs
    - Provide a list of "Providers" whose food the user enjoys the most.  
        *Might even be an avenue for Providers to create coupons or something that allows for continued business*


## Excuses, excuses

- I was, perhaps, too ambitious up front.  
    - I wanted to create the "faked" ability for a user to place an order (see above for why) and though I have the data structures in place .. ran out of time on the UI side.
    - Orders didn't happen at all
    - Dietary Needs never surfaced in the UI due to time.
    
- I thought It'd be neat to take into account dietary needs and/or ratings in schedule generation as well but ran out of time.


## The Ask 

Rotate Schedule for Lunches

```
* First Week
* Monday->Chicken-and-waffles
* Tuesday->Tacos
* Wednesday->Curry
* Thursday->Pizza
* Friday->Sushi

* Second Week
* Monday->Breakfast-for-lunch
* Tuesday->Hamburgers
* Wednesday->Spaghetti
* Thursday->Salmon
* Friday->Sandwiches
```
