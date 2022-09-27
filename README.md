# Callbacks
---
# Callbacks

---
# Callbacks
## What are they

---
# Callbacks
## What are they


From rails guide :
> During the normal operation of a Rails application, objects may be created, updated, and destroyed. Active Record provides hooks into this object life cycle so that you can control your application and its data.

> Callbacks allow you to trigger logic before or after an alteration of an object's state.

---
# Callbacks
## What are they
### Callback list
#### Create

  - before_validation
  - after_validation
  - before_save
  - around_save
  - before_create
  - around_create
  - after_create
  - after_save
  - after_commit / after_rollback

---
# Callbacks
## What are they
### Callback list
#### Update

  - before_validation
  - after_validation
  - before_save
  - around_save
  - before_update
  - around_update
  - after_update
  - after_save
  - after_commit / after_rollback

---
# Callbacks
## What are they
### Callback list
#### Destroy

  - before_destroy
  - around_destroy
  - after_destroy
  - after_commit / after_rollback

---
# Callbacks
## What are they
### Callback list
#### Special

  - after_initialize
  - after_find
  - after_touch

---
# Callbacks
## What are they
### Callback list
#### Ways to skip callbacks

- decrement!
- decrement_counter
- delete
- delete_all
- delete_by
- increment!
- increment_counter
- insert
- insert!
- insert_all
- insert_all!
- touch_all
- update_column
- update_columns
- update_all
- update_counters
- upsert
- upsert_all

---
# Callbacks
## What are they
### Callback list
#### Ways to skip callbacks
#### THAT WE USE !

- delete_all
- upsert
- update_all
---
# Callbacks
## What are they
### How to cancel a callback chain

```ruby
throw(:abort)
```
---
# Callbacks
## What are they
### How to cancel a callback chain

```ruby
throw(:abort)
```
> It's the only place I've every seen a throw in a ruby codebase so here how it's used
```ruby
catch(:abort) do
  i = 0
  loop do
    throw(:abort) if i == 10
    puts i
    i += 1
  end
end
```

---
# Callbacks
## What are they
### Demo

```ruby
callbacker = Callbacker.create
callbacker.update title: :bond
callbacker.destroy
```

---
# Callbacks
## What are they
### Demo

```ruby
callbacker = Callbacker.create
callbacker.belongs_tos.create
```

---
# Callbacks
## What are they
### Demo

```ruby
callbacker = Callbacker.create
h = HasMany.create
h.callbackers.create
h.destroy
```

---
# Callbacks
## What are they
### Demo

```ruby
callbacker = Callbacker.create
h = HasMany.create
h.callbackers.create
h.destroy # no callbacks with nullify
```
---
# Callbacks
## What are they
#### Demo

```ruby
callbacker = Callbacker.create
h = HasMany.create
h.callbackers.create
h.destroy # callbacks with destroy
```
---
# Callbacks
## Why the hate
### Single Responsibility Principle

> A module should be responsible to one, and only one, actor.
> A responsibility is a reason to change
- Wikipedia example :
  - report generator class
    - two responsibilities :
      - layout
      - content
    - needs two classes

- easier to read/refacto
- easier to test

---
# Callbacks
## Why the hate
### Single Responsibility Principle

A model is a class to help with data handling of a specific a table.

It's responsibility should be the table schema and data handling.
So when we ask a model to send a mail, enqueue an SQS message, sync on auth0, on segment...
We don't respect the Single Responsibility Principle

---
# Callbacks
## Why the hate
### Single Responsibility Principle

A model is a class to help with data handling of a specific a table.

It's responsibility should be the table schema and data handling.
So when we ask a model to send a mail, enqueue an SQS message, sync on auth0, on segment...
We don't respect the Single Responsibility Principle

> But we still kind of respect the SRP by using external classes when needed.
> We don't define the logic to send mail/sync on auth0/enqueue an SQS message on the model classes
> We just call the other classes in the model.

---
# Callbacks
## /!\ What we should not do /!\

update self in a callback
```ruby
# you can
self.attribute = value
# but you can't
update(attribute: value)
```

---
# Callbacks
## /!\ What we should not do /!\

update another record in a callback
```ruby
# you just can't, even in a separated class
# the way to do it is to create a service
```

---
# Callbacks
## /!\ What we should not do /!\

use callbacks that are in the transaction
```ruby
# around_create/update/destroy
# after_create/update/destroy
# around_save
# after_save
```

---
# Callbacks
## /!\ What we should not do /!\

use callbacks in after_commit that can raise without a rescue
A callback that raise in an after_commit will not revert the transaction
but it will still bubble up and prevent future callbacks from being called
