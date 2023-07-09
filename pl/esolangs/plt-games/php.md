# Replace PHP (May 2013)

[Competition](https://web.archive.org/web/20140909011352/http://www.pltgames.com/competition/2013/5)

## Description

PHP is the language everyone loves to hate. It's filled with design mistakes and
inconsistencies.

But it does have a few reasons for why it's popular:

- It was widely used yesterday (inertia)
- Small runtime
- Portable with few dependencies
- Low barrier to writing a single-file dynamic web page

While we can't easily achieve the first point, we might be able to do fairly
well in the last three. We might even be able to do it and have a well designed
language!

The goals for this competition is to write a small and portable language with
few dependencies. It needs to be very easy to build and install on a web server.

Let's do better than PHP!

### Inspiration

[phpreboot](https://code.google.com/archive/p/phpreboot/)

```phpreboot
<html>
 <body>
  <ol>
   {
     resultset = select * from foo where name = 'bar'
     foreach(resultset as value)
     {
       echo <li>$(value.name)</li>
     }
   }
  </ol>
 </body>
</html>
```

[Snowscript](https://github.com/runekaagaard/snowscript)

```snowscript
fn how_big_is_it(number)
    if number < 100
        <- "small"
    else
        <- "big"
```

### Resources

- [PHP Sucks, But It Doesn't Matter](https://blog.codinghorror.com/php-sucks-but-it-doesnt-matter/)
- [The PHP Singularity](https://blog.codinghorror.com/the-php-singularity/)

## Submissions

This competition received no submissions.
