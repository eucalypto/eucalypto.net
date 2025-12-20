---
title: "Dr. Functionallove or: How I Learned to Stop Worrying and Love Immutability"
type: "post"
date: 2021-07-21T19:50:04+02:00
subtitle: "How the real world taught me to embrace immutable data structures"
image: "/posts/2021-07-21-immutable-data-classes/2021-07-21-mutable-list-adapter.webp"
tags: [immutable, functional, side-effects, RecyclerView, ListAdapter, Room]
---

So I'm working on this [Time Tracker Android App](https://github.com/eucalypto/time-tracker) that among other things displays a list of so-called Categories.

I'm using the typical tools for that: a [RecyclerView](https://developer.android.com/guide/topics/ui/layout/recyclerview) with a [ListAdapter](https://developer.android.com/reference/androidx/recyclerview/widget/ListAdapter) that takes its list from a [LiveData](https://developer.android.com/topic/libraries/architecture/livedata) provided by the [Room](https://developer.android.com/training/data-storage/room) database library.

The following image shows what's happening:

![image](/post/2021-07-21-immutable-data-classes/2021-07-21-mutable-list-adapter.webp)

The database (Room) issues a list of Categories (-2) which is given to the Display (-1) (aka ListAdapter as part of Recyclerview). When there is an update in the database (2) (can be toggled by the view (1) or by another component), it issues a new list of Categories (3). The Display (ListAdapter) compares those two lists to find the most elegant display update strategy and executes that update.

So far so normal. This is where real life begins which taught me the following lesson the hard way: _be aware of side-effects_.

In my case the user can use the Display to update a Category (change its name) in step (1). This code has a reference to the Category list element α. At this point, the Category class is an immutable data class meaning you can't change the fields after creating an object. I followed this pattern because it's often recommended. But while writing this updating code, in my naivety, I thought it would be a good idea to relax that immutability to get some convenience. So I changed the Category data class to allow the setting of a new name, and used that new freedom here. So what the code now did in step (1) was to change the name of this object with the reference α and then toggle the database to update that object (2).

**Turns out, that was a mistake**, because now the displayed list of categories did _not_ update after the user finished updating that particular Category.

It took me a long time to find a suitable solution (that you may already guess by looking at the title of this article). And it took me the rest of the day until lying in bed trying to fall asleep that I finally understood what's actually going on and why the solution worked. ^-^

**The solution was to make Category immutable again.**

But before arriving at that conclusion, I tried out a few things. First, the nuclear option in RecyclerView: `Adapter.notifyDataSetChanged()` did work, but this negates all the effort of using a ListAdapter since it re-draws _everything_. Then I thought, the database write and following issue of a new list did not work properly. But that turned out to be wrong. Room worked like a charm, which I figured out using the Database Inspector of Android Studio. It showed that the database is updated at the exact right time. And strangely enough, when I used this database inspector to manually update the name of a category, the displayed list was updated perfectly fine. So we could exclude the database and Room as the culprit.

Now, the final solution was, again, to make Category immutable, which solved the problem but took me a while to understand how.

The magic words here are **side-effects** and **immutability**.

Let's step through the steps (picture above) again and see what happened before the solution. The list of categories is given as a LiveData, which is in itself immutable (you can't change that list), but since it only stores references to objects, it can't enforce immutability of those said objects. So in the end, the supposedly immutable list of Categories was mutable (2nd order). And said mutability brought this confusing side effect of not updating the display.

So what happened? The updating code took the reference to the Category object, updated it (1) and toggled a database update (2). The side-effect here is that the original list of Categories got "updated" by updating this element in this list.

Room took this update happily (2), and issued a new list of Categories for the Display (3). The Display (ListAdapter) also happily took this new list and compared it with the "old" one (4). And here is exactly where this side-effect showed itself: while comparing the "old" list with the new one, ListAdapter found that the object α has the very _same_ data in both lists! The new list has the updated object α\* because it got it from the database, and the "old" list has the updated object α\* because our code updated it as an unwanted side-effect.
ListAdapter is very efficient (aka lazy) and says: this Category α\* is the same in both lists, so it *has not changed*. That assumption is wrong, but the Display (ListAdapter) doesn't know it. So it **sees no need to update the view** even though the view is very outdated.

And that's it. By making the Category class immutable, we also made the list of categories that we get from the database fully immutable. The updating code has to create a new Category object with an updated name and give this new object to the database to update. And this new object lives _outside_ the list. Now the newly issued list _is_ different from the old one and the Display (ListAdapter) sees that change and dutifully updates the view.

To learn more about the superpowers of immutability, read Joshua Bloch's book [_Effective Java (3rd ed.)_](https://www.amazon.com/Effective-Java-Joshua-Bloch/dp/0134685997) "Item 17: Minimize Mutability".


If you want to see the code, have a look at the state of my app [before the bugfix](https://github.com/eucalypto/time-tracker/commit/dba79e99c02c8e564eeafc137e33e8fc9c153f5e) and [after the bugfix](https://github.com/eucalypto/time-tracker/commit/053c0f4c2264b88f7369a48dc6d2981f6d9936ac).